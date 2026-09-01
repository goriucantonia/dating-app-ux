# UX Repository — Shared Architecture

Status: planning locked 2026-09-01. Applies to every UI module file in this repo. Stack per `technical_details.md`: Flutter/Dart, one codebase for Mobile, Web, Desktop.

---

## 1. App-wide technical decisions (trades named)

1. **State management: Riverpod.** Providers per feature, `AsyncNotifier` for anything backed by an API call. *(Chosen over Bloc for less ceremony at this app's size; over setState because polling + auth + cross-screen state need real DI.)*
2. **Navigation: go_router** with typed routes. Route guards: unauthenticated → login; authenticated but baseline questionnaire incomplete → questionnaire (the "nothing works without it" gate lives here, in one place).
3. **API layer: dio + a hand-written repository per server module** (`AuthRepository`, `ProfileRepository`, `AnalysisRepository`, `ChatRepository`), returning freezed models mirroring the server's JSON. *(Trade: no OpenAPI codegen this phase — the API surface is ~20 endpoints and codegen tooling churn outweighs typing them once. Revisit if the API triples.)* JWT stored via `flutter_secure_storage` (mobile/desktop) / carefully-scoped localStorage (web); dio interceptor attaches it and routes 401s to login.
4. **One polling primitive.** A single reusable `Poller` (Riverpod provider) that polls `GET /analyses/{id}` with interval 3s, backs off to 10s after 2 minutes, stops on terminal states, and survives screen navigation — the analysis keeps polling app-wide because the server keeps working when the user wanders off (async-first contract). No SSE/WebSocket, matching the server decision.
5. **Every async screen designs four states up front:** loading / content / empty / error-with-retry. The module files below only call out the states that are non-obvious; the four-state rule is global and non-optional (review finding: failure states are where trust dies).
6. **Theming:** Material 3, light + dark from one seed color, system-following. Demo profiles get one shared visual treatment (a "Demo" chip component used everywhere a user is rendered — schema's `is_demo` must never be dropped by a widget).
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
