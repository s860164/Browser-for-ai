#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server
# Connects to a VISIBLE Chrome via Chrome DevTools Protocol (CDP).
# No extensions needed — just Chrome with remote debugging enabled.

set -euo pipefail

# Ensure common Node.js paths are in PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

CDP_PORT=9222
PROFILE_DIR="${HOME}/.browser-for-ai/chrome-profile"
mkdir -p "$PROFILE_DIR"

# Check if Chrome is already running with remote debugging
if ! curl -s "http://localhost:${CDP_PORT}/json/version" &>/dev/null; then
  # Launch Chrome with remote debugging enabled
  if [ -d "/Applications/Google Chrome.app" ]; then
    open -na "Google Chrome" --args \
      --remote-debugging-port=${CDP_PORT} \
      --user-data-dir="$PROFILE_DIR" \
      --no-first-run \
      --no-default-browser-check
  elif command -v google-chrome &>/dev/null; then
    google-chrome \
      --remote-debugging-port=${CDP_PORT} \
      --user-data-dir="$PROFILE_DIR" \
      --no-first-run \
      --no-default-browser-check &
  elif command -v google-chrome-stable &>/dev/null; then
    google-chrome-stable \
      --remote-debugging-port=${CDP_PORT} \
      --user-data-dir="$PROFILE_DIR" \
      --no-first-run \
      --no-default-browser-check &
  else
    echo "ERROR: Google Chrome not found" >&2
    exit 1
  fi

  # Wait for Chrome to start and CDP to become available
  for i in $(seq 1 30); do
    if curl -s "http://localhost:${CDP_PORT}/json/version" &>/dev/null; then
      break
    fi
    sleep 1
  done
fi

# Connect Playwright MCP to the visible Chrome via CDP
exec npx -y @playwright/mcp@latest \
  --cdp-endpoint "http://localhost:${CDP_PORT}" \
  --caps "vision,pdf" \
  --viewport-size 1280x720
