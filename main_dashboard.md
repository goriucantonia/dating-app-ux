# UX Module Plan — Main Dashboard

Status: planning locked 2026-09-01. Server counterparts: `candidate_matching.md` (analyses endpoints). Note: the global browsable user feed was cut at spec level (decision log) — the dashboard is trigger + history, nothing else.

---

## 1. Screen: `/` (home)

Three zones, top to bottom:

1. **Analysis Trigger Hero.** "Find the Right Person" — the app's one big button. `POST /analyses`, then navigate to `/analyses/:id`. States:
   - *Ready:* button active.
   - *Already running:* the server's 409 is pre-empted client-side — the hero morphs into a live progress card for the in-flight analysis (tapping goes to `/analyses/:id`). One analysis at a time is a server rule; the UI presents it as "your analysis is running," not as a rejection.
   - *Not eligible yet:* persona not ready → the hero explains the actual blocker and links to it ("Finish your 5 questions first").
2. **Latest result card** (when the newest analysis is `complete`): top match name + score + "continue where you left off" → results or active chat.
3. **Analysis history.** `GET /analyses`, newest first: date, status chip (`matched / simulating / complete / no_candidates / failed`), top candidate + score when complete. Tap → detail. Tombstone rendering for candidates whose accounts were deleted ("this person removed their account"). Empty state for new users: one line of what an analysis will do, arrow up at the hero.

## 2. Async behavior

- History is a plain fetch-on-focus provider. The in-flight analysis card subscribes to the shared app-wide `Poller` — the same instance the progress screen uses, so leaving and returning to the dashboard never spawns a second polling loop.
- `no_candidates` renders as an honest, calm card: "No one in the pool fits your filters yet" with the pool explanation from the server — not an error, not a retry-spinner.

## 3. Decisions (trades named)

1. **No user browsing on the dashboard** — reaffirms the feed cut; the toggle lives in Settings. The dashboard sells exactly one action.
2. **History is the spine of the screen.** Results being revisitable was a table-stakes review finding; making history primary (rather than a buried menu item) is what makes long-running background simulations feel safe to walk away from.
