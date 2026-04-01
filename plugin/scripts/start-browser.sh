#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server with persistent Chrome profile
# This script ensures environment variables expand correctly and the browser
# retains login sessions (cookies, localStorage) across restarts.

set -euo pipefail

# Ensure common Node.js paths are in PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

PROFILE_DIR="${HOME}/.browser-for-ai/chrome-profile"
mkdir -p "$PROFILE_DIR"

# Detect available browser: prefer Chrome, fallback to Chromium
BROWSER_ARG=""
if [ -d "/Applications/Google Chrome.app" ] || \
   command -v google-chrome &>/dev/null || \
   command -v google-chrome-stable &>/dev/null || \
   [ -f "/opt/google/chrome/chrome" ]; then
  # Real Chrome found — best for Google login (avoids bot detection)
  BROWSER_ARG="--browser chrome"
else
  # Try to find Playwright's bundled Chromium
  CHROMIUM_PATH=""
  # Check common Playwright cache locations
  for dir in "${HOME}/.cache/ms-playwright" "${HOME}/Library/Caches/ms-playwright" "${HOME}/.cache/playwright"; do
    if [ -d "$dir" ]; then
      # Find the chromium executable
      FOUND=$(find "$dir" -name "chromium" -o -name "chrome" -type f -perm +111 2>/dev/null | head -1)
      if [ -n "$FOUND" ]; then
        CHROMIUM_PATH="$FOUND"
        break
      fi
    fi
  done

  # Also check npx playwright install path
  if [ -z "$CHROMIUM_PATH" ]; then
    # Try to install chromium if not present
    npx -y playwright install chromium 2>/dev/null || true
    for dir in "${HOME}/.cache/ms-playwright" "${HOME}/Library/Caches/ms-playwright" "${HOME}/.cache/playwright"; do
      if [ -d "$dir" ]; then
        FOUND=$(find "$dir" -name "chromium" -o -name "chrome" -type f -perm +111 2>/dev/null | head -1)
        if [ -n "$FOUND" ]; then
          CHROMIUM_PATH="$FOUND"
          break
        fi
      fi
    done
  fi

  if [ -n "$CHROMIUM_PATH" ]; then
    BROWSER_ARG="--browser chromium --executable-path $CHROMIUM_PATH"
  else
    # Last resort: use default chromium and hope Playwright can find it
    BROWSER_ARG="--browser chromium"
  fi
fi

# No --headless flag = visible browser window.
exec npx -y @playwright/mcp@latest \
  $BROWSER_ARG \
  --user-data-dir "$PROFILE_DIR" \
  --caps "core,tabs,pdf,history,wait,files,install" \
  --viewport-size 1280,720
