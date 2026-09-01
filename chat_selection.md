# UX Module Plan — Chat Selection & Further Actions

Status: planning locked 2026-09-01. Server counterpart: `chat.md`. Final UX module.

---

## 1. Screens and flow

### Selection (lives on the results dashboard footer)
- **"Choose [name]"** per candidate. Confirm sheet states the deal in two lines: "You'll chat with an AI version of [name] that remembers your simulated dates. [Name] won't be notified — real conversations aren't part of this phase." Then `POST /analyses/{id}/select` → navigate to the new session.
- One selection per analysis (server-enforced); after selecting, the other candidates' buttons become "already chose [name]" — visible, not hidden, so the constraint is legible.

### `/chat` — session list
- Active sessions first, then ended; each row: match name, Demo chip if applicable, last message preview, link back to the originating analysis. Tombstones for deleted matches ("this person removed their account" — session gone from the server, the list explains rather than 404s).

### `/chat/:sessionId` — Immersive Live AI Chat
- The shared chat widget (same one calibration uses): text field, send, message bubbles. **No metadata badges here** — server sends none (chat metadata stays hidden by design; the meters would turn conversation into gauge-gaming).
- Header: match name + a persistent, quiet "AI persona" tag — immersive, never deceptive. Tapping the header opens a summary sheet: their trait labels, the date digest ("what you two 'did'"), and a link to the original transcripts.
- Reply latency (a few seconds, no streaming) is styled as a typing indicator that starts when the request fires and resolves into the bubble. Send failure → the message stays in the composer marked unsent with a retry — user text is never dropped. The server's "couldn't reply, try again" give-up error renders as exactly that, in-thread.
- **Navigation Controls** (overflow menu, per the Source of Truth): End chat (confirm; row moves to ended, history stays readable), Improve my profile (→ `/profile/expand`), Start a new analysis (→ dashboard hero; allowed while a chat stays active — chatting and re-analyzing are independent).

## 2. Async behavior and data flow

- History pages backward via `?after_seq=` on scroll-up; the session provider holds the merged list.
- Send is strictly sequential per session (composer disabled while a reply is pending) — matches the server's request–response turn model; no optimistic bubbles for the persona side, the user bubble renders immediately.

## 2a. Built 2026-09-01 (Step 14) — decisions made while building, inline

- **History loads every page on open** rather than paging backward on scroll-up. Chats at friends scale are small, the wire is the same `?after_seq=` contract, and a scroll-up paginator is the kind of plumbing that breaks silently. Revisit if a chat outgrows a few hundred messages.
- **On a failed send the user's bubble is withdrawn, an in-thread notice says exactly what the server said, and the text goes back into the composer marked "Not sent yet".** The server rolls its copy back too (`chat.md`), so the retry is a clean re-send, never a double post.
- **The shared chat widget gained three parameters, not branches:** `typingLabel` (the typing indicator), `composerEnabled` (an ended chat keeps its history and loses its composer), and `ChatBubble.isError` (a centred notice that can never be mistaken for a spoken line). Calibration passes none of them and is unchanged.
- **The selection footer reads the session list to render "already chose [name]"** — one provider (`selectionForAnalysisProvider`) derives it, so the results screen and the chat list cannot disagree about whether a choice was made.

- **A vanished chat is a person who left** (built 2026-09-01, Step 15). The server cascades the session away with the match's account, so opening it is a 404; the chat screen renders "This person removed their account, so this chat is gone with them." with a way back to the list, never a retry button over a row that will not come back.

## 3. Decisions (trades named)

1. **Confirm sheet before selection.** Cost: one extra tap on the app's climactic action. Accepted: it's the one irreversible choice in an analysis, and it's where the not-notified honesty must land — after this, the app behaves as if a relationship exists.
2. **Persistent "AI persona" tag over full immersion.** Cost: breaks the fantasy a few pixels' worth. Accepted: the immersive frame plus a friend's real name without the tag drifts into the app lying about what it is.
3. **One shared chat widget across calibration and match chat.** Cost: the widget carries a config surface (flagging on/off, metadata on/off). Accepted: two hand-rolled chat UIs is how the two chats drift apart in behavior and bugs.

---

*UI/UX Repository planning is complete: `ux_architecture.md`, `new_user_creation.md`, `profile_settings.md`, `main_dashboard.md`, `simulate_date_page.md`, `simulation_results.md`, `chat_selection.md`. The full-system architectural plan is now in place across both repos.*
