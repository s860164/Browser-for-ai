---
name: browser-tips
description: Best practices for browser automation with Playwright MCP tools. Auto-activates when browser tools are used.
model-invocable: true
---

# Browser Automation Best Practices

When using the browser MCP tools (`mcp__plugin_browser-for-ai_browser__*`), follow these guidelines for reliable automation:

## Element Selection Priority

1. **Accessibility snapshot first** — Always call `browser_snapshot` before interacting with a page. It gives you the accessibility tree with element roles, names, and structure.
2. **Text content** — Click by visible text: `browser_click` with the element's text label. Most reliable.
3. **ARIA labels** — Use `aria-label` or `role` attributes when visible text isn't unique.
4. **CSS selectors** — Use as fallback: `[data-testid="..."]` > `#id` > `.class` > tag hierarchy.
5. **Coordinates** — Last resort only. Take a screenshot, identify pixel location, click there.

## Verification Pattern

After every significant action:
1. Perform the action (click, type, navigate)
2. Wait briefly if the page needs to load (`browser_wait`)
3. Take a snapshot or screenshot to verify the result
4. If unexpected, diagnose with `browser_console_messages` or `browser_network_requests`

## Error Recovery

- **Element not found?** → Take a snapshot, the page may have changed. Try alternative selectors.
- **Page didn't load?** → Check `browser_network_requests` for failed requests. Try `browser_navigate` again.
- **Login required?** → Tell the user to run `/browser-login` first.
- **Bot detection / CAPTCHA?** → Inform the user they need to solve it manually in the browser window.

## Performance Tips

- Batch related reads: get snapshot + screenshot in one sequence rather than alternating
- Don't screenshot every minor action — use snapshots (text-based) for most checks, screenshots only when visual layout matters
- Close unused tabs to reduce memory usage

## Google-Specific Tips

- Gmail: Use `browser_snapshot` to read email content — it's structured with ARIA roles
- Google Drive: File lists are navigable via accessibility tree
- Google Calendar: Event details appear in accessible dialogs after clicking
