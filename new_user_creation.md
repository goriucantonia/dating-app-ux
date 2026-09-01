# UX Module Plan — New User Creation

Status: planning locked 2026-09-01. Server counterpart: `module_1_data_collection.md` A1–A2, A4 (auth + questions + answers endpoints).

---

## 1. Screens and flow

```
/register ──► /onboarding/questions (BQ1..BQ5, one per page) ──► /profile (traits appear) ──► /
   ▲                                    │
/login ◄── existing account             └── leave anytime; resume exactly where left off
```

### `/register`
- The exact form from `module_1_data_collection.md` A1, in three short steps (account → about you → who you're looking for). Client-side validation mirrors the server CHECKs (18+, age range sanity, ≥1 interested-in) so errors appear at the field, not after submit.
- Opt-in toggle appears here, default off, one-line description — settable later in Settings; registration never blocks on it.
- Before the questionnaire starts, one interstitial states the deal plainly: "5 questions, about 10 minutes. Write like you talk — the AI learns your voice from this. Nothing works without it."

### `/onboarding/questions`
- One question per page, `1 of 5` progress. Large multiline field, character counter that turns from muted to confirmed at 200 chars (server minimum), with the nudge text from A2 under the field.
- **Save per answer:** `PUT /answers/{question_id}` fires on page advance *and* on a 2-second idle debounce, so closing the app mid-sentence loses at most a couple of words. Resume: `GET /questions` drives "first unanswered question" on return; the route guard (in `ux_architecture.md`) sends any signed-in user with unanswered baseline questions here.
- After BQ5: a single "Building your profile…" screen calls `POST /profile/extract` then `POST /persona/compile`, polling snapshot status; lands on `/profile` with traits visible. Extraction failure → error state with retry — the answers are safe, only the processing is retried.

## 2. Async behavior and data flow

- All five answers live server-side the moment each page advances; the client holds no unsaved state worth losing.
- The extract → compile chain is the app's first long-ish wait (~10–30s). It gets the full four-state treatment; the loading state names what's happening ("Reading your answers… Extracting traits… Building your persona…") driven by the two job statuses, not a fake timer.

## 3. Decisions (trades named)

1. **One question per page.** Cost: five navigations. Accepted: a wall of five textareas invites three-word answers; one big canvas per question signals "write a lot," which persona fidelity depends on.
2. **No email verification, no password reset flow this phase.** Friends pool; a forgotten password is fixed by the owner in the database. *(Named so nobody assumes it exists; returns to scope with strangers.)*
3. **Debounced autosave over an explicit save button.** Cost: a few extra PUTs. Accepted: save/resume was a table-stakes review finding; a save button is a thing users forget to press.
