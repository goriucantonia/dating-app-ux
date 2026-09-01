# UX Module Plan — Simulation Execution & Results

Status: planning locked 2026-09-01. Server counterparts: `date_simulation.md` (transcripts, evaluations, scores). The progress/loading half of this module lives in `simulate_date_page.md`; this file is the results half.

---

## 1. Screens

### `/analyses/:id/results` — Post-Date Analytics Dashboard
- **Candidate ranking:** the (up to) 3 candidates ordered by `final_score`, score rendered with its composition on tap — the four rubric criteria and their weights, verbatim from `judge_rubric.v1`. The score explains itself or it's just a number *(the owner's stance: scores come from exact checks — so show the checks)*.
- Per candidate, per date: setting name, date score, `is_partial` badge where the date was incomplete ("scored from a partial date — weighted half"), clicked-subjects chips, and clashes rendered as plain sentences: "Your *impatience* rubbed against their *need to think things through* when the food was late."
- **Satisfaction curves:** per-date line chart of both peers' `satisfaction` and `connection` over message sequence, built from the stored per-turn state — event markers drawn on the timeline where environment rows occurred (the visible payoff of state tracking). Rendered with `fl_chart`; both curves interactive (scrub to see the message at that point, tap-through to the transcript anchored there).
- Failed/excluded dates listed with their reason — absent data is labeled absent, never smoothed over.
- Footer: the **Ultimate Match Selection** control (owned by `chat_selection.md`).

### `/dates/:id` — Enhanced Transcript Viewer
- Chat-style transcript: user's agent right-aligned, candidate's left, **environment events as centered context blocks** ("🌩 A sudden downpour sends everyone under the awning").
- **Metadata toggle** (global switch in the app bar, default on): each bubble grows a badge row — emotional state, state of mind, connection %, satisfaction %. Off = clean read; on = the spectacle. The toggle state persists per user.
- Natural-ending footer states how the date ended: "They both felt it was a natural place to stop" vs "Time was up" (`mutual_wants_to_end` vs `cap` — the server logs it; the UI says it).
- Deep-linkable with a `?seq=` anchor (used by the satisfaction-curve scrubbing).

## 2. Async behavior and data flow

- Results provider fetches `GET /analyses/{id}/dates` once on `complete` (no polling — terminal state); transcripts fetch lazily per date and cache in memory for the session.
- During `simulating`, the transcript viewer is reachable for completed dates (per `simulate_date_page.md`) with a "dates still running" banner instead of the analytics header — same widgets, partial data, honestly framed.

## 3. Decisions (trades named)

1. **Score composition is always one tap away.** Cost: exposes that the weights are opinions. Accepted deliberately — a bare "78" invites either blind trust or blind distrust; the breakdown invites reading the dates, which is the actual product.
2. **Clashes rendered as sentences naming both traits.** This is the analytics' core promise from the Source of Truth ("which specific quality or flaw did not align"); chips or scores alone would bury it.
3. **Charts scrub to transcript.** Cost: a bit of plumbing. Accepted: the curve's only job is to make you ask "what happened at message 14?" — the answer must be one tap, not a scroll hunt.
