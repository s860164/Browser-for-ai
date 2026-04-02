#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server with persistent browser profile
# Uses vision cap so Claude can see screenshots and the browser window is VISIBLE.

set -euo pipefail

# Ensure common Node.js paths are in PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

PROFILE_DIR="${HOME}/.browser-for-ai/chrome-profile"
mkdir -p "$PROFILE_DIR"

# Default to chromium (works everywhere, including cloud sandboxes)
BROWSER="chromium"

# Upgrade to real Chrome only if definitely available
if [ -d "/Applications/Google Chrome.app" ]; then
  BROWSER="chrome"
elif [ -f "/opt/google/chrome/chrome" ]; then
  BROWSER="chrome"
elif command -v google-chrome &>/dev/null; then
  BROWSER="chrome"
elif command -v google-chrome-stable &>/dev/null; then
  BROWSER="chrome"
fi

# Ensure Playwright has the browser installed
npx -y playwright install "$BROWSER" 2>/dev/null || true

# --caps vision  = screenshot-based interaction + VISIBLE browser window
# --caps pdf     = save pages as PDF
# Valid caps: vision, pdf, devtools (NOT --vision as standalone flag!)
# Browser is HEADED by default (no --headless flag needed)
exec npx -y @playwright/mcp@latest \
  --browser "$BROWSER" \
  --user-data-dir "$PROFILE_DIR" \
  --caps "vision,pdf" \
  --viewport-size 1280x720
