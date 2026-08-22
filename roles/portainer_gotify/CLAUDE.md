# portainer_gotify

## Purpose

Deploys the Gotify push-notification server itself, used by `gotify_message`, Diun, and the maintenance agent's own run notifications.

## Managed image(s)

- `gotify/server` via `gotify_tag` (currently `3.0.0`) - https://github.com/gotify/server/releases

## Known upgrade constraints

- v3.0.0 breaking: config.yml no longer supported (must use env vars), API tokens only exposed on creation/rotation, session elevation required for sensitive actions

## Other notes

This service being down breaks notifications for everything else - treat upgrades cautiously and verify a test message still delivers afterward.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

- v3.0.0: No config.yml migration needed (role doesn't mount one). Test notification delivery post-upgrade. Re-save any API tokens that were only stored in external systems (they're now hashed in the DB).

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-22: 2.2.5 → 3.0.0 (major version with breaking changes) - PR #102

