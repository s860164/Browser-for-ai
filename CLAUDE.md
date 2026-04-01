# Browser-for-AI

A Claude Code plugin that provides Playwright-powered browser automation with persistent login sessions.

## Architecture

- Wraps Microsoft's `@playwright/mcp` package (not a custom MCP server)
- Uses a shell script wrapper (`scripts/start-browser.sh`) for environment variable expansion
- Persistent Chrome profile stored at `~/.browser-for-ai/chrome-profile/`
- Plugin structure follows Claude Code plugin conventions

## Key Files

- `.mcp.json` — MCP server configuration, points to the shell wrapper
- `scripts/start-browser.sh` — Launches Playwright MCP with Chrome, persistent profile, headed mode
- `scripts/setup.sh` — One-time installer for Playwright browsers
- `skills/browser-login/` — `/browser-login` command for initial Google auth
- `skills/browser/` — `/browser` command for general browser tasks
- `skills/browser-tips/` — Auto-activated best practices for browser tools
- `agents/web-researcher.md` — Multi-step web research subagent

## MCP Tool Naming

Tools from this plugin are named: `mcp__plugin_browser-for-ai_browser__<tool_name>`

Example: `mcp__plugin_browser-for-ai_browser__browser_navigate`
