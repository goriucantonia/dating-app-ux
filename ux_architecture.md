# UX Repository — Shared Architecture

Status: planning locked 2026-09-01. Applies to every UI module file in this repo. Stack per `technical_details.md`: Flutter/Dart, one codebase for Mobile, Web, Desktop.

---

## 1. App-wide technical decisions (trades named)

1. **State management: Riverpod.** Providers per feature, `AsyncNotifier` for anything backed by an API call. *(Chosen over Bloc for less ceremony at this app's size; over setState because polling + auth + cross-screen state need real DI.)*
2. **Navigation: go_router** with typed routes. Route guards: unauthenticated → login; authenticated but baseline questionnaire incomplete → questionnaire (the "nothing works without it" gate lives here, in one place).
3. **API layer: dio + a hand-written repository per server module** (`AuthRepository`, `ProfileRepository`, `AnalysisRepository`, `ChatRepository`), returning freezed models mirroring the server's JSON. *(Trade: no OpenAPI codegen this phase — the API surface is ~20 endpoints and codegen tooling churn outweighs typing them once. Revisit if the API triples.)* JWT stored via `flutter_secure_storage` (mobile/desktop) / carefully-scoped localStorage (web); dio interceptor attaches it and routes 401s to login.
4. **One polling primitive.** A single reusable `Poller` (Riverpod provider) that polls `GET /analyses/{id}` with interval 3s, backs off to 10s after 2 minutes, stops on terminal states, and survives screen navigation — the analysis keeps polling app-wide because the server keeps working when the user wanders off (async-first contract). No SSE/WebSocket, matching the server decision.
5. **Every async screen designs four states up front:** loading / content / empty / error-with-retry. The module files below only call out the states that are non-obvious; the four-state rule is global and non-optional (review finding: failure states are where trust dies).
5b. **Navigation (added 2026-09-02, D-018):** ONE `StatefulShellRoute.indexedStack` with four branches — Home, Profile, Chats, Settings — persistent on every signed-in screen, hidden on login, register and onboarding. Each branch keeps its own stack; every other screen is nested under the branch it belongs to, reached with `push` (not `go`, which replaces the stack and is why `/profile` used to be a dead end). Back is the shared `BackTo` widget: pop if there is something to pop, the branch root otherwise, so a deep link always has somewhere to go.

6. **Theming:** Material 3, light + dark, system-following. **Revised 2026-09-01:** the scheme is no longer derived from one seed colour — it is the **Modernist** design system (`Matchmaking app UI design/`, tokens in `_ds/modernist-*/styles.css`) written out in `lib/app/theme.dart`: one accent on an off-white ground, zero corner radius, 2px rules, Archivo, flush-left labels. `ColorScheme.fromSeed` cannot hold a mono palette — it invents a tertiary and a secondary hue this system does not have. Changing the app's look is still one file, and the extra roles (plot ground, curve strokes, rule ink) live in the `Modernist` `ThemeExtension` beside it. Demo profiles get one shared visual treatment (a "Demo" chip component used everywhere a user is rendered — schema's `is_demo` must never be dropped by a widget).
7. **Layout:** phone-first; on web/desktop widths > 840px, content constrained to a centered column (~720px). No per-platform layouts this phase. *(Trade: desktop looks like a big phone; accepted — friends pool, function over polish.)*

## 2. Screen map (route table)

| Route | Screen | Module file |
|---|---|---|
| `/login`, `/register`, `/onboarding/questions` | Auth + baseline questionnaire | `new_user_creation.md` |
| `/profile`, `/profile/expand`, `/profile/calibration`, `/settings` | Profile, traits, calibration, settings | `profile_settings.md` |
| `/` (home) | Dashboard: trigger + history | `main_dashboard.md` |
| `/analyses/:id` | Matches reveal + simulation progress | `simulate_date_page.md` |
| `/analyses/:id/results`, `/dates/:id` | Results dashboard + transcript viewer | `simulation_results.md` |
| `/chat`, `/chat/:sessionId` | Selection outcome + live chat | `chat_selection.md` |

## 3. Cross-cutting UI obligations from server decisions

- `pool_status = partial / empty` → honest copy, never a fake-success screen (`simulate_date_page.md`).
- `incomplete` dates → labeled in viewer and analytics, partial scores explained (`simulation_results.md`).
- Deleted counterpart ("this person removed their account") → dangling analyses and chats render a tombstone, not a crash (`chat_selection.md`, `main_dashboard.md`).
- Trait metadata (`confidence`, `status`) is part of the trait payload and part of the display — an inferred guess must look like a guess (`profile_settings.md`).
