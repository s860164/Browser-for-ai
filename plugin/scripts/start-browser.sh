#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server with persistent browser profile
# Uses --vision mode so the browser window is VISIBLE and Claude can see screenshots.

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

# --vision  = VISIBLE browser window + screenshot-based interaction
# Without --vision, @playwright/mcp defaults to headless + accessibility snapshots
exec npx -y @playwright/mcp@latest \
  --browser "$BROWSER" \
  --user-data-dir "$PROFILE_DIR" \
  --vision \
  --viewport-size 1280,720
