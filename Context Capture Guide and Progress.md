# Context Capture: Guide and Progress

Nov 7, 2026 · @Dinesh

## What it is and why

Context Capture is a Chrome extension that collects what went wrong on a web page, so you can hand it to an AI coding tool (Claude Code, Cursor, ChatGPT) in one paste instead of opening DevTools and explaining by hand.

**Before:** you see a broken button, open DevTools, copy the red error, find the failed request, take a screenshot, then type "the Upgrade button in the pricing card, I think it's PlanCard.tsx". The AI still guesses.

**After:** click the extension, pick the broken button, paste. The AI gets the errors, the failed requests, the component name and the exact file and line. No DevTools, no guessing.

Everything stays on your computer. Passwords, tokens and emails are hidden before anything is copied.

## Install

1. Open `chrome://extensions` and turn on **Developer mode** (top right).
2. Click **Load unpacked** and select the extension folder, for example `C:\Users\hp\Desktop\context-capture`. The picker shows only folders; select the folder itself.
3. Pin the icon: puzzle-piece icon in the toolbar, then the pin next to Context Capture.
4. Reload any tab that was already open.

**Updating:** when a new build is copied into the same folder, click the circular **reload** arrow on the Context Capture card. Don't edit or format files in that folder; it is a built copy.

## How to use each part

### 1. Connection check (available now)

- **What:** the popup tells you whether the extension can read this page.
- **How:** click the icon. "Connected to page" means it works. "Capture is not available on this page" appears on Chrome's own pages (`chrome://…`, the Web Store, PDFs), where Chrome blocks all extensions.
- **Example:** on `localhost:3000` → Connected. On `chrome://settings` → not available.

### 2. Error list (available now)

- **What:** every error and warning on the page from the last 60 seconds, without opening DevTools.
- **How:** reload the page once after installing, use the app until something breaks, click the icon.
- **Example:** a button reads `plan.price` when `plan` is undefined. The popup shows `error · uncaught · Cannot read properties of undefined (reading 'price') · src/components/PlanCard.tsx:18`.
- **Catches:** `console.error`, `console.warn`, uncaught errors, unhandled promise rejections and React render crashes. Repeats are grouped with a count (×12).

### 3. Element picker (available now)

- **What:** point at the exact thing that is broken.
- **How:** click the icon, then **Capture element**. Hover and a box highlights what is under the mouse. Click to select it, type an optional note ("button does nothing") and press Enter. **Capture area** works the same, but you drag a rectangle. Esc cancels.
- **Good to know:** while picking, your page's own click handlers do not fire, so picking a "Delete" button never deletes anything.

### 4. Failed network requests (in the copied report)

- **What:** API calls that returned 400/500 or failed, with the start of the error body.
- **Example:** `GET /api/plans → 500: {"error":"db timeout"}`.

### 5. Secret hiding (in the copied report)

- **What:** before anything is copied, tokens, passwords, cookies, API keys and emails become `[redacted]`.
- **Example:** `/api/user?token=abc123&page=2` becomes `/api/user?token=[redacted]&page=2`.

### Also available

- **React detection:** the component chain and the exact file and line of what you picked (`PricingPage > PlanCard > UpgradeButton`, `src/components/UpgradeButton.tsx:42`).
- **Copy for AI:** one click puts everything above on your clipboard, ready to paste.
- **Screenshot:** a cropped picture of what you picked, saved next to the report.
- **Shortcut and settings:** `Alt+Shift+C` to start picking; choose what to include.

## Example: what you will paste into Claude

One capture gives you this. Paste it into Claude Code and the AI knows where to look.

```markdown
## UI issue: /pricing
**Element:** <button>Upgrade to Pro</button>
**Component chain:** PricingPage > PlanCard > UpgradeButton
**Source:** src/components/pricing/UpgradeButton.tsx:42

**Errors (last 60 s):**
- TypeError: Cannot read properties of undefined (reading 'price')
  at PlanCard (src/components/pricing/PlanCard.tsx:18)

**Failed requests:**
- GET /api/plans?token=[redacted] → 500: {"error":"db timeout"}

**Note:** button does nothing when clicked
```

## Progress tracker

Updated Nov 10, 2026. All features are built. The extension is packaged as `context-capture-v0.1.0.zip` and ready for Chrome Web Store submission (store files are in `store/`).

| # | Feature | Status | What you can see |
| --- | --- | --- | --- |
| 1 | Foundation and connection | Done | "Connected to page" in the popup |
| 2 | Element picker | Done | Capture element / Capture area buttons |
| 5 | Error capture | Done | Error list in the popup |
| 6 | Network failures | Done | Failed requests in the copied report |
| 7 | Secret hiding | Done | `[redacted]` and `[email]` in the copied report |
| 4 | React detection | Done | Component chain and source file:line |
| 3 | Screenshot | Done | PNG in `Downloads\context-capture\` |
| 8 | Copy for AI | Done | Report on the clipboard after you press Enter |
| 9 | Shortcut and settings | Done | `Alt+Shift+C`, settings page |
| 10 | Release | Packaged | Icons, privacy policy, listing text, screenshots. You still need to submit it |

Tests on the release build (Nov 10): 31 of 31 tests in real Chrome pass, plus a full capture on a React 19 demo app (picker, note, clipboard report, redaction, source mapping, screenshot).

**The source is out of date.** `context-capture-source.bundle` only goes up to feature 4. The newer source for features 3, 8 and 9 isn't on this computer. Rebuilding from the bundle would lose those features, and would undo the release fixes (icons, no `scripting` permission).
## Limits and tips

- **Reload the page after installing or updating.** Errors are recorded from page load, so earlier ones are not seen.
- **Chrome's own pages can't be captured** (`chrome://`, the Web Store, the PDF viewer).
- **The last 60 seconds only.** Older errors drop off so the report stays focused.
- **Top frame only.** Content inside iframes is highlighted as a whole but not inspected yet.
- **Nothing leaves your computer.** No servers, no accounts, no analytics.
