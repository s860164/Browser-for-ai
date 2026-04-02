---
name: browser-login
description: Log into Google (or any site) in the persistent browser. Opens a VISIBLE Chrome window so you can complete login manually. Session persists across restarts.
user-invocable: true
argument: "[url]"
allowed-tools:
  - "mcp__plugin_browser-for-ai_browser__*"
---

# Browser Login

Help the user log into a website using the persistent browser. The browser uses a persistent profile directory so login sessions survive across restarts.

## Instructions

1. **Navigate to the login page:**
   - If the user provided a URL argument, navigate there
   - Otherwise, navigate to `https://accounts.google.com`

2. **Take a screenshot** using `browser_take_screenshot` to show the user the current state

3. **Tell the user to find the Chrome window:**
   > A Chrome window has opened on your desktop showing the login page (see screenshot above).
   >
   > **How to find it:**
   > - Look for a new Chrome window on your desktop
   > - Use **Mission Control** (swipe up with 3 fingers, or press F3) to see all windows
   > - Or **Cmd+Tab** to switch between apps — look for Chrome
   > - The window title should show "Google Sign in" or similar
   >
   > Please complete the login directly in that Chrome window. Once done, let me know!

4. **Wait for the user to confirm** they've completed login

5. **Take another screenshot** to verify the login state

6. **Confirm to the user** that their session is now saved and will persist across browser restarts.

## Important Notes

- The browser uses **--vision mode** so the window IS visible on the user's desktop
- Do NOT try to type passwords or interact with login forms yourself — let the user do this for security
- The persistent profile is stored at `~/.browser-for-ai/chrome-profile/`
- To reset login state, the user can delete that directory and run setup again
- If the user still can't find the window, suggest checking other macOS Spaces/Desktops
