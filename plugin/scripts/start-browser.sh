#!/usr/bin/env bash
# Browser-for-AI: Start Playwright MCP server
# Keep it simple — let Playwright handle everything.

set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

PROFILE_DIR="${HOME}/.browser-for-ai/chrome-profile"
mkdir -p "$PROFILE_DIR"

# Playwright MCP defaults:
#   - Headed (visible) by default
#   - Uses Chrome if available, falls back to Chromium
# --caps vision = Claude can see screenshots
# --user-data-dir = persistent login sessions
exec npx -y @playwright/mcp@latest \
  --user-data-dir "$PROFILE_DIR" \
  --caps "vision,pdf"
