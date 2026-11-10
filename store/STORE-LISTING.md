# Chrome Web Store submission: copy-paste answers

Upload `context-capture-v0.1.0.zip` from the project folder.

## Store listing tab

**Name:** Context Capture

**Summary (132 characters max):**
Click any element on a React app and paste its component, errors and screenshot into your AI coding tool.

**Category:** Developer Tools  **Language:** English

**Detailed description:**

Stop explaining bugs to your AI by hand.

Context Capture collects what went wrong on a web page and turns it into one paste-ready report for Claude Code, Cursor, ChatGPT or any AI coding tool. You don't need to open DevTools or guess at file names.

HOW IT WORKS
1. Click the extension icon, or press Alt+Shift+C.
2. Pick the broken element, or drag a box around an area.
3. Add a short note if you want, then paste the report into your AI tool.

WHAT THE REPORT CONTAINS
• The element you picked, plus its React component chain and the exact source file and line
• Console errors and warnings from the last 60 seconds, including uncaught errors, promise rejections and React crashes
• Failed API requests (4xx/5xx), with the start of the error body
• A cropped screenshot of what you picked
• Your note

PRIVATE BY DESIGN
• Everything stays on your computer: no servers, no accounts, no analytics
• Tokens, passwords, cookies, API keys and emails are replaced with [redacted] before anything is copied
• While you pick, the page's own click handlers don't fire, so picking a "Delete" button never deletes anything

GOOD TO KNOW
• Reload the page after installing, because errors are recorded from page load onwards
• Chrome blocks extensions on its own pages (chrome://, the Web Store and the PDF viewer)

**Images:**
- Store icon 128×128: `icons/icon-128.png`
- Small promo tile 440×280: `store/promo-440x280.png`
- Screenshots at 1280×800, upload in this order: `store/screenshots/screenshot-1-pick-element.png` to `screenshot-4-settings.png`. Each is a real capture of this build running on a demo React app.

## Privacy practices tab

**Single purpose:**
Collect debugging context from the element a developer picks on a web page (errors, failed requests, React component and source location, and a screenshot) and copy it as one report for an AI coding tool.

**Permission justifications:**

| Permission | Justification |
| --- | --- |
| Host permission `<all_urls>` | Developers pick elements on any site they are building, including localhost and staging domains, which can't be listed in advance. The content scripts must start at page load to record console errors and failed requests from the beginning. Nothing is read or sent until the user starts a capture. |
| activeTab | Capture a screenshot of the visible tab the user is working in, to crop to the picked element. |
| downloads | Save the cropped screenshot as a PNG in the user's Downloads folder so it can be attached to the report. |
| clipboardWrite | Copy the finished report to the clipboard when the user clicks Copy. |
| offscreen | Manifest V3 service workers can't write to the clipboard, so an offscreen document performs the clipboard write. |
| storage | Save the user's settings, such as which sections to include in the report. |

**Remote code:** No, I am not using remote code. All JavaScript is packaged in the extension.

**Data usage:** tick **Website content** only. The extension reads page errors, failed requests and the picked element, but only locally and only when the user asks for a report. Leave every other category unticked.

Tick all three certifications:
- I do not sell or transfer user data to third parties, outside of the approved use cases.
- I do not use or transfer user data for purposes that are unrelated to my item's single purpose.
- I do not use or transfer user data to determine creditworthiness or for lending purposes.

**Privacy policy URL:** host `store/PRIVACY.md` publicly and paste the link here. A public GitHub repo, GitHub Pages or a public Gist all work.

