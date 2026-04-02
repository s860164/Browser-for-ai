---
name: browser-login
description: Log into any website using the Playwright browser. Navigate to login page, let user complete authentication, verify login status.
user-invocable: true
argument: "[url]"
allowed-tools:
  - "mcp__plugin_browser-for-ai_browser__*"
---

# Browser Login

You MUST use the `mcp__plugin_browser-for-ai_browser__*` tools (NOT computer-use, NOT Claude in Chrome).

## Instructions

1. **Navigate to the login page:**
   - Use `browser_navigate` to go to the URL the user specified
   - If no URL given, go to `https://accounts.google.com`

2. **Take a screenshot** using `browser_take_screenshot` and show it to the user

3. **Tell the user:**
   > I've opened the login page. The browser window should be visible on your desktop.
   > Please complete the login in that window. Once done, let me know!
   >
   > If you can't see the browser window, I'll show you screenshots of what's happening and can help type your credentials (except passwords).

4. **Wait for user confirmation**

5. **Take another screenshot** to verify login status

6. **Confirm** the session is saved and will persist.

## IMPORTANT

- ALWAYS use `mcp__plugin_browser-for-ai_browser__*` tools
- NEVER fall back to computer-use or other browser tools
- Do NOT type passwords — let the user handle that part
- The persistent profile is at `~/.browser-for-ai/chrome-profile/`
