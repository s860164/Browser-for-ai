#!/usr/bin/env bash
# Browser-for-AI: One-time setup script
# Installs Playwright browsers and creates the persistent profile directory.

set -euo pipefail

# Ensure common Node.js paths are in PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:$PATH"

echo "=== Browser-for-AI Setup ==="
echo ""

# 1. Check Node.js
if ! command -v node &>/dev/null; then
  echo "ERROR: Node.js is required but not installed."
  echo "Install it from https://nodejs.org/ or via: brew install node"
  exit 1
fi
echo "Node.js: $(node --version)"

# 2. Check npx
if ! command -v npx &>/dev/null; then
  echo "ERROR: npx is required but not found."
  exit 1
fi
echo "npx: available"

# 3. Install @playwright/mcp (also triggers Playwright browser install)
echo ""
echo "Installing @playwright/mcp and Playwright browsers..."
npx -y @playwright/mcp@latest --help >/dev/null 2>&1 || true

# 4. Install Playwright browsers (Chrome specifically)
echo ""
echo "Ensuring Chrome browser is installed for Playwright..."
npx -y playwright install chrome 2>/dev/null || npx -y playwright install chromium 2>/dev/null || {
  echo "WARNING: Could not install Chrome via Playwright."
  echo "The plugin will try to use your system Chrome instead."
}

# 5. Create persistent profile directory
PROFILE_DIR="${HOME}/.browser-for-ai/chrome-profile"
mkdir -p "$PROFILE_DIR"
echo ""
echo "Profile directory: $PROFILE_DIR"

# 6. Verify Chrome is available
if command -v google-chrome &>/dev/null || \
   command -v google-chrome-stable &>/dev/null || \
   [ -d "/Applications/Google Chrome.app" ] || \
   [ -f "/usr/bin/google-chrome" ]; then
  echo "Chrome: found"
else
  echo "WARNING: System Chrome not detected."
  echo "Playwright may use its own Chromium. Google login may trigger bot detection."
  echo "Install Chrome from https://www.google.com/chrome/ for best results."
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code (so the MCP server registers)"
echo "  2. Run /browser-login to log into Google"
echo "  3. Use /browser for any browser task"
echo ""
