#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server
# Uses --extension mode to connect to the user's VISIBLE Chrome browser.
# This ensures the browser is always visible regardless of environment.

set -euo pipefail

# Ensure common Node.js paths are in PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

# --extension mode connects to an already-running Chrome/Edge browser
# via the "Playwright MCP Bridge" extension. This guarantees visibility
# because it uses the user's actual Chrome window.
# --caps vision = screenshot-based interaction (Claude can see the page)
# --caps pdf    = save pages as PDF
exec npx -y @playwright/mcp@latest \
  --extension \
  --caps "vision,pdf" \
  --viewport-size 1280x720
