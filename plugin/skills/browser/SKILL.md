---
name: browser
description: Perform any browser task — navigate, click, type, screenshot, scroll. Uses persistent Chrome with your saved login sessions.
user-invocable: true
argument: "<task description or URL>"
allowed-tools:
  - "mcp__plugin_browser-for-ai_browser__*"
---

# Browser Automation

Perform browser tasks using the persistent Chrome browser. This browser retains all login sessions (Google, etc.) so you can access authenticated pages directly.

## Instructions

Given the user's task description or URL:

1. **Plan** what browser actions are needed
2. **Execute** the actions using the available Playwright MCP tools
3. **Verify** each step with screenshots when the result matters
4. **Report** back to the user with what was found or accomplished

## Available Tools

The Playwright MCP server provides these core tools:

### Navigation
- `browser_navigate` — Go to a URL
- `browser_go_back` / `browser_go_forward` — History navigation
- `browser_wait` — Wait for network idle or specific timeout

### Interaction
- `browser_click` — Click an element (by text, CSS selector, or coordinates)
- `browser_type` — Type text into a focused element
- `browser_select_option` — Select from a dropdown
- `browser_hover` — Hover over an element
- `browser_press_key` — Press keyboard keys

### Observation
- `browser_snapshot` — Get accessibility tree (best for finding elements)
- `browser_take_screenshot` — Capture visible page as image
- `browser_console_messages` — Read browser console output
- `browser_network_requests` — See network activity

### Tabs
- `browser_tab_list` — List open tabs
- `browser_tab_new` — Open a new tab
- `browser_tab_select` — Switch to a tab
- `browser_tab_close` — Close a tab

## Best Practices

1. **Start with `browser_snapshot`** to understand the page structure before clicking
2. **Use text-based selectors** (`browser_click` with `text=` or visible text) — they're more robust than CSS selectors
3. **Take screenshots after important actions** to verify the result
4. **Use `browser_wait`** after navigation or actions that trigger page loads
5. **Check `browser_console_messages`** if something seems broken
6. **For forms:** snapshot → identify fields → type into each → verify → submit
