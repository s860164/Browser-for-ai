---
name: browser-login
description: Log into Google (or any site) in the user's VISIBLE Chrome browser. Uses the Playwright MCP Bridge extension to control the real Chrome window.
user-invocable: true
argument: "[url]"
allowed-tools:
  - "mcp__plugin_browser-for-ai_browser__*"
---

# Browser Login

Help the user log into a website using their real, visible Chrome browser. The plugin uses **--extension mode** which connects to Chrome via the Playwright MCP Bridge extension.

## Pre-requisites Check

Before navigating, verify the extension is set up:

1. **Tell the user** they need the Playwright MCP Bridge extension in Chrome:
   > To use this browser plugin, you need the **Playwright MCP Bridge** extension installed in Chrome:
   >
   > 1. Open Chrome on your desktop
   > 2. Go to the Chrome Web Store and search for **"Playwright MCP Bridge"**
   >    or visit: `https://chromewebstore.google.com/detail/playwright-mcp-bridge/gjgkljfaondcbhkfbnjpmjehlbkbgooo`
   > 3. Click **Add to Chrome**
   > 4. After installing, you should see the Playwright icon in your extensions bar
   >
   > Once installed, let me know and I'll navigate to the login page!

2. **Wait for user confirmation** that the extension is installed

## Login Flow

1. **Navigate to the login page:**
   - If the user provided a URL argument, use `browser_navigate` to go there
   - Otherwise, navigate to `https://accounts.google.com`

2. **Take a screenshot** using `browser_take_screenshot` to show the user what Chrome is displaying

3. **Tell the user:**
   > I've navigated your Chrome browser to the login page. You should see it in your Chrome window right now.
   >
   > Please complete the login directly in Chrome. Once you're done, let me know!

4. **Wait for the user to confirm** they've completed login

5. **Take another screenshot** to verify the login state

6. **Confirm to the user** that their login is active. Since we're using their real Chrome browser, the session persists naturally with Chrome's own profile.

## Important Notes

- This plugin uses **--extension mode**: it controls the user's actual Chrome browser, NOT a separate hidden instance
- The Chrome window is ALWAYS visible because it's the user's real Chrome
- Do NOT try to type passwords or interact with login forms yourself — let the user do this for security
- If browser tools fail, the Playwright MCP Bridge extension might not be installed or Chrome might not be open
