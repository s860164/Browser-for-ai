---
name: browser-login
description: Log into Google (or any site) in the persistent browser. Opens a visible Chrome window so you can complete login manually. Session persists across restarts.
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

2. **Take a screenshot** to show the current state of the browser

3. **Tell the user:**
   > The browser window is now open and showing the login page. Please complete the login directly in the Chrome window that appeared on your screen.
   >
   > Once you've finished logging in, let me know and I'll verify the login was successful.

4. **Wait for the user to confirm** they've completed login

5. **Take another screenshot** to verify the login state

6. **Confirm to the user** that their session is now saved and will persist across browser restarts. They won't need to log in again unless they clear the profile.

## Important Notes

- The browser window is VISIBLE on the user's screen — they interact with it directly
- Do NOT try to type passwords or interact with login forms yourself — let the user do this for security
- The persistent profile is stored at `~/.browser-for-ai/chrome-profile/`
- To reset login state, the user can delete that directory and run setup again
