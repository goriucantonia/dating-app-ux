# UX Module Plan — Simulate Date Page (Matches Reveal + Progress)

Status: planning locked 2026-09-01. Server counterparts: `candidate_matching.md` (analysis + candidates), `date_simulation.md` (pipeline + `progress`).

---

## 1. Screen: `/analyses/:id` — one screen, three phases by status

### Phase 1 — `matching`
Brief indeterminate state ("Checking who fits…"); usually seconds.

### Phase 2 — `matched`: the reveal
- **Top 3 Match Display:** candidate cards revealed with a light stagger animation — name, age, Demo chip when `is_demo`, compatibility as a percentage, and the **computed** reasons: shared interest chips (`shared_interests`) + the one-line `reason_summary`. Nothing on this card is generated copy; it renders exactly what matching stored (server decision: reasons must be true, not plausible).
- `pool_status='partial'` → the same reveal with 1–2 cards plus a plain banner: "Only N people fit your filters right now — simulating with them." `no_candidates` → honest empty screen (copy from `main_dashboard.md`), no simulate button.
- **Candidate Breakdown:** cards expand to the candidate's public trait summary (their trait labels by category — descriptions stay private to them) so the user can size candidates up before burning simulation time.
- **"Start Simulated Dates"** → `POST /analyses/{id}/simulate` → phase 3. *(Explicit button kept rather than auto-chaining: the reveal is a decision point — the user may want to fix their profile after seeing who the pool offers before spending tens of minutes of simulation.)*

### Phase 3 — `simulating`: the wait
- Multi-stage progress fed by the server's `progress` JSONB via the shared `Poller` — real stage names ("Date 2 of 6 — at the car meet", "Judging Maria's dates…"), never a fake percentage bar.
- A checklist grid of the (up to) 6 dates: pending / running / complete / incomplete-with-reason. Completed dates unlock immediately — **transcripts are readable while later dates still run** (the checkpointed rows already exist server-side; this is the payoff).
- The prominent affordance of this phase: **"You can leave — this keeps running."** Dashboard hero shows the same live card; on `complete`, a local notification (mobile/desktop) and an in-app banner link to results. *(Built 2026-09-01, Step 13: the in-app banner fires app-wide from the one poller when it sees `simulating → complete|failed` LIVE — a cold load of a finished analysis announces nothing. The OS-level notification is the browser Notification API on web only, permission asked on the "Start Simulated Dates" tap because browsers require a gesture; desktop/mobile OS notifications need a plugin and are an owed item in PICKUP. Named trade: no plugin this phase, the banner is the guarantee.)*
- `failed` analysis → error state naming the stage that died, with a retry that calls `/simulate` again (server resume makes retry cheap — it continues, not restarts; the copy says so: "picks up where it stopped"). *(Built 2026-09-01: the server now accepts `/simulate` on a `failed` analysis that has candidates; one that failed in matching has nothing to resume and the screen offers "Start a new analysis" instead. After the POST the poller is `kick()`ed so it polls through the terminal status the row may still report — see D-013.)*

## 2. Decisions (trades named)

1. **One route, phase-switched by status.** The analysis is one server object with one lifecycle; splitting reveal/progress into separate routes invents client state the server doesn't have. Deep links land correctly in any phase, including after the app was killed.
2. **Early transcript access during simulation.** Cost: the user can read date 1 before its candidate's score exists. Accepted: it turns a tens-of-minutes dead wait into the product's most engaging moment, and it's free — the data is already checkpointed.
3. **Manual simulate button (not auto-chain).** Named above; the server keeps `/simulate` explicit for exactly this.
