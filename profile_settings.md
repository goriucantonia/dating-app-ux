# UX Module Plan — User Profile & Settings

Status: planning locked 2026-09-01. Server counterparts: `module_1_data_collection.md` (traits, dispute, dynamic questions), `trait_persona.md` (calibration, snapshot status).

---

## 1. Screens

### `/profile` — trait display
- Traits grouped by category (interests, qualities, flaws, behavior, conversation style, what you're looking for), rendered as cards: `label` prominent, `description` below.
- **A guess must look like a guess:** each card shows its `status` — `inferred` gets a dotted border + "AI's read, not confirmed" hint; `confirmed` solid; `disputed` amber with "being corrected." Confidence renders as a subtle 3-step strength dot, not a percentage *(trade: less precision on screen; accepted — "0.62 confident you're stubborn" reads as absurd theater)*.
- Card actions: **"That's right"** → confirm (`status='confirmed'`); **"That's wrong"** → `POST /traits/{id}/dispute`, which tells the user a follow-up question was added and deep-links to it.
- Header shows persona snapshot state: "Persona v3 · up to date" or "Profile changed — persona will rebuild" (from `traits_hash` mismatch), with a rebuild action.
- Auto-refreshes after any extraction (the implicit-update trigger from the Source of Truth).

### `/profile/expand` — progressive expansion
- **"Answer 5 more questions"** button with pool progress ("15 of 30 answered") → `GET /questions/next-batch` → renders the batch with the same one-per-page answering UI reused from onboarding (same widget, same autosave). Completing a batch triggers extract → compile with the same "Building…" screen. An abandoned batch resumes at the same remaining questions.
- **Pool exhausted** (`status: 'pool_exhausted'`): the button is replaced by a completed state — "You've answered everything — your profile is as deep as it gets for now. Keep it sharp by editing old answers." — styled as an achievement, not an error.
- **Editing past answers:** every answered question (baseline, pool, dispute) is listed with its answer and an edit action → same one-question editor → on leaving the edit session, re-extraction runs and the persona-staleness header updates. Copy notes that edits change future matches, not past results.

### `/profile/calibration` — meet your AI self (optional)
- Chat UI (shared chat widget from `chat_selection.md`). Banner: "This is your AI double. Talk to it. If a line doesn't sound like you, long-press and flag it."
- Long-press / hover → **"I'd never say that"** → optional "what would you say instead?" one-liner → `POST /calibration/messages/{id}/flag`. Flagged bubbles show a small mark; a footer counts flags and offers "Rebuild persona with these corrections."

### `/settings`
- Opt-in toggle (`PATCH /me`) with its one-line description; account fields + preferences editing; theme; **Delete account** — a two-step confirm that states what deletion does, including the cross-user effect in plain words ("your simulated dates disappear from your friends' results too"), then shows the server's returned deletion counts as the final receipt. *(Built 2026-09-01, Step 15: the receipt lists only non-zero tables, and the app signs out only after the receipt is dismissed — the person reads what went before they are back at the login screen.)*

## 2. Async behavior and data flow

- Trait list, snapshot status, and question batches are `AsyncNotifier` providers; extraction/compilation reuse the polling primitive.
- Dispute and confirm are optimistic updates (card flips state instantly, rolls back on error) — these are single-row writes, the one place optimism is safe.

## 3. Decisions (trades named)

1. **Confirm/dispute directly on the card, one tap.** The dispute loop only corrects the profile if using it is effortless; burying it in a menu means inferred guesses silently harden into facts (§9).
2. **Persona staleness surfaced, rebuild manual (with an auto-rebuild after each completed batch).** Cost: a user can chat against a stale persona for a while. Accepted: silent background rebuilds mid-calibration would swap the persona under the user's feet.
3. **Calibration reuses the real chat pipeline against the real snapshot** — no special "calibration mode" prompt. What you flag is exactly what a date agent would have said.
