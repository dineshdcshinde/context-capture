# Context Capture Privacy Policy

Last updated: November 10, 2026

Context Capture is a Chrome extension that helps developers report problems on web pages to AI coding tools. This policy explains what the extension reads and where that information goes.

## Summary

Everything stays on your computer. Context Capture has no servers, no accounts, no analytics and no tracking. It never sends data to the developer or to any third party.

## What the extension reads

The extension reads the following only from the tab you are using, and only to build a report you ask for:

- **Console errors and warnings** from the last 60 seconds, including uncaught errors and unhandled promise rejections.
- **Failed network requests** (HTTP 4xx/5xx responses and network errors): the method, the URL, the status and the start of the response body.
- **The element you pick**: its HTML tag, its text, and, on React apps, the component names and source file locations.
- **A screenshot** of the visible tab, cropped to the area you picked.
- **The note you type**, if you add one.

## What happens to it

- Before anything is copied, the extension replaces tokens, passwords, cookies, API keys and email addresses with `[redacted]`.
- The report is copied to **your clipboard** when you click Copy. Where you paste it is up to you.
- The screenshot is saved as a PNG file in **your Downloads folder**.
- Your settings are saved in Chrome's local extension storage on your device.
- Captured errors and requests are held in memory only, and are discarded after 60 seconds or when the tab is closed.

## What the extension does not do

- It does not send any data over the network.
- It does not sell or share data, or use it for advertising or credit decisions.
- It does not collect personal information, browsing history or analytics.
- It does not load or run remote code.

## Permissions

- **Access to all websites:** you can pick an element on any site you are developing, including `localhost`. Error and request logging has to start when the page loads, so the extension runs on every page, but it only builds a report when you ask for one.
- **activeTab:** to capture a screenshot of the tab you are using.
- **downloads:** to save the screenshot PNG.
- **clipboardWrite and offscreen:** to copy the report to your clipboard.
- **storage:** to remember your settings.

## Contact

Questions about this policy: dineshshinde81563@gmail.com
