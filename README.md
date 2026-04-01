# Browser-for-AI

A Claude Code plugin that gives Claude a **real, visible Chrome browser** with persistent login sessions. Built on Microsoft's official Playwright MCP server.

## Features

- **Persistent Google Login** — Log in once, stay logged in across restarts
- **Visible Browser** — See exactly what Claude is doing (not headless)
- **Fast & Reliable** — Direct Playwright automation, no screen-matching issues
- **20+ Browser Tools** — Navigate, click, type, screenshot, scroll, tabs, and more
- **Easy Sharing** — Standard Claude Code plugin format

## Quick Start

### 1. Install

```bash
# Clone the repo
git clone https://github.com/user/browser-for-ai.git

# Run setup (installs Playwright + Chrome)
cd browser-for-ai
bash scripts/setup.sh
```

### 2. Register with Claude Code

```bash
# Option A: Install as plugin (recommended)
# In Claude Code, run:
#   /plugin install /path/to/browser-for-ai

# Option B: Manual MCP registration
claude mcp add browser -- bash /path/to/browser-for-ai/scripts/start-browser.sh
```

### 3. Restart Claude Code

The browser MCP server will start automatically.

### 4. Log into Google

In Claude Code, type:

```
/browser-login
```

Chrome opens visibly. Complete your Google login in the browser window. Your session is now saved permanently.

### 5. Use It

```
/browser go to Gmail and check for unread emails
/browser search Google for "playwright mcp server"
/browser open Google Calendar and show today's events
```

## Slash Commands

| Command | Description |
|---------|-------------|
| `/browser-login [url]` | Open browser for manual login (defaults to Google) |
| `/browser <task>` | Perform any browser task with natural language |

## How It Works

This plugin wraps [`@playwright/mcp`](https://github.com/microsoft/playwright-mcp) with:

- **`--browser chrome`** — Uses real Chrome (not Chromium) for best Google compatibility
- **`--user-data-dir ~/.browser-for-ai/chrome-profile/`** — Cookies & sessions persist
- **No `--headless`** — Browser window is visible on your screen
- **`--viewport-size 1280,720`** — Reasonable default window size

## Available Browser Tools

### Navigation
- `browser_navigate` — Go to URL
- `browser_go_back` / `browser_go_forward` — History
- `browser_wait` — Wait for page load

### Interaction
- `browser_click` — Click elements
- `browser_type` — Type text
- `browser_select_option` — Dropdowns
- `browser_hover` — Hover
- `browser_press_key` — Keyboard

### Observation
- `browser_snapshot` — Accessibility tree (fast, text-based)
- `browser_take_screenshot` — Visual capture
- `browser_console_messages` — Console output
- `browser_network_requests` — Network activity

### Tabs
- `browser_tab_list` / `browser_tab_new` / `browser_tab_select` / `browser_tab_close`

## Troubleshooting

### Browser doesn't open
- Run `bash scripts/setup.sh` to ensure Playwright is installed
- Check that Chrome is installed on your system

### Google login shows bot detection
- Make sure you're using `--browser chrome` (real Chrome), not Chromium
- The persistent profile helps avoid repeated login challenges

### Session lost after restart
- The profile directory is `~/.browser-for-ai/chrome-profile/`
- Make sure this directory wasn't deleted
- Run `/browser-login` to log in again if needed

### Reset everything
```bash
rm -rf ~/.browser-for-ai/chrome-profile/
bash scripts/setup.sh
```

## Requirements

- Node.js 18+
- Google Chrome (recommended) or Chromium
- macOS, Linux, or Windows (with bash/WSL)

## License

MIT
