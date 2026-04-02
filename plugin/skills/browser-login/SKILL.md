---
name: browser-login
description: Log into Google (or any site) in the user's VISIBLE Chrome browser. Connects via CDP to control the real Chrome window on the desktop.
user-invocable: true
argument: "[url]"
allowed-tools:
  - "mcp__plugin_browser-for-ai_browser__*"
---

# Browser Login

Help the user log into a website using their real, visible Chrome browser. The plugin launches Chrome with remote debugging and connects via CDP, so the browser window is always visible on the user's desktop.

## Instructions

1. **Navigate to the login page:**
   - If the user provided a URL argument, use `browser_navigate` to go there
   - Otherwise, navigate to `https://accounts.google.com`

2. **Take a screenshot** using `browser_take_screenshot` to show the user the current state

3. **Tell the user:**
   > I've navigated Chrome to the login page. A Chrome window should be visible on your desktop.
   >
   > Please complete the login directly in that Chrome window. Once you're done, let me know!

4. **Wait for the user to confirm** they've completed login

5. **Take another screenshot** to verify the login state

6. **Confirm to the user** that their login is active. The session is saved in `~/.browser-for-ai/chrome-profile/` and persists across restarts.

## Important Notes

- This plugin launches a REAL Chrome window with remote debugging (port 9222)
- The Chrome window uses a separate profile directory so it won't interfere with the user's normal Chrome
- Do NOT try to type passwords or interact with login forms yourself — let the user do this for security
- If the tools fail to connect, Chrome may need to be restarted — tell the user to quit all Chrome windows and try again
- To reset login state, delete `~/.browser-for-ai/chrome-profile/` directory
