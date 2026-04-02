---
name: browser
description: Perform any browser task — navigate, click, type, screenshot, scroll. Uses Playwright to control a real browser with persistent login sessions.
user-invocable: true
argument: "<task description or URL>"
allowed-tools:
  - "mcp__plugin_browser-for-ai_browser__*"
---

# Browser Automation

You MUST use the `mcp__plugin_browser-for-ai_browser__*` tools (NOT computer-use, NOT Claude in Chrome).

## Instructions

Given the user's task description or URL:

1. **Navigate** using `browser_navigate` to go to the target URL
2. **Take a screenshot** using `browser_take_screenshot` to show the user what's on screen
3. **Interact** using `browser_click`, `browser_type`, `browser_press_key`, etc.
4. **Verify** with screenshots after important actions
5. **Report** back to the user with what was found or accomplished

## IMPORTANT: Tool Selection

- ALWAYS use tools starting with `mcp__plugin_browser-for-ai_browser__`
- NEVER fall back to computer-use or Claude in Chrome tools
- If a browser tool fails, retry or report the error — do NOT switch to other tools

## Available Tools

### Navigation
- `browser_navigate` — Go to a URL
- `browser_navigate_back` — Go back

### Interaction
- `browser_click` — Click an element by text or CSS selector
- `browser_type` — Type text into a focused element
- `browser_select_option` — Select from a dropdown
- `browser_hover` — Hover over an element
- `browser_press_key` — Press keyboard keys
- `browser_fill_form` — Fill form fields
- `browser_mouse_click_xy` — Click at specific x,y coordinates

### Observation
- `browser_take_screenshot` — Capture the page as an image (SHOW THIS TO THE USER)
- `browser_snapshot` — Get accessibility tree (text-based, good for finding elements)
- `browser_console_messages` — Read browser console
- `browser_network_requests` — See network activity

### Tabs
- `browser_tabs` — List open tabs

## Best Practices

1. **Always take a screenshot** after navigating or performing important actions — this shows the user what's happening
2. **Use `browser_snapshot`** to understand page structure before clicking
3. **Use text-based selectors** for clicking — more robust than CSS selectors
4. **Take screenshots frequently** so the user can follow along
