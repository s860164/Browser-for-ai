#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server with persistent Chrome profile
# This script ensures environment variables expand correctly and Chrome
# retains login sessions (cookies, localStorage) across restarts.

set -euo pipefail

# Ensure common Node.js paths are in PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

PROFILE_DIR="${HOME}/.browser-for-ai/chrome-profile"
mkdir -p "$PROFILE_DIR"

# Use real Chrome for best Google login compatibility (avoids bot detection).
# No --headless flag = visible browser window.
exec npx -y @playwright/mcp@latest \
  --browser chrome \
  --user-data-dir "$PROFILE_DIR" \
  --caps "core,tabs,pdf,history,wait,files,install" \
  --viewport-size 1280,720
