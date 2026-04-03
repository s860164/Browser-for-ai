#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server
# Detects Chrome vs Chromium, installs if needed, then starts MCP.

set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

PROFILE_DIR="${HOME}/.browser-for-ai/chrome-profile"
mkdir -p "$PROFILE_DIR"

# Detect: use Chrome on macOS/desktop, Chromium everywhere else
BROWSER="chromium"
if [ -d "/Applications/Google Chrome.app" ]; then
  BROWSER="chrome"
elif [ -f "/opt/google/chrome/chrome" ]; then
  BROWSER="chrome"
elif command -v google-chrome &>/dev/null; then
  BROWSER="chrome"
fi

# IMPORTANT: Install the browser BEFORE starting MCP server
# This prevents "browser not found" errors in sandbox environments
npx -y playwright install "$BROWSER" 2>/dev/null || npx -y playwright install chromium 2>/dev/null || true

exec npx -y @playwright/mcp@latest \
  --browser "$BROWSER" \
  --user-data-dir "$PROFILE_DIR" \
  --caps "vision,pdf"
