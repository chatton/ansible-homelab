# portainer_gotify

## Purpose

Deploys the Gotify push-notification server itself, used by `gotify_message`, Diun, and the maintenance agent's own run notifications.

## Managed image(s)

- `gotify/server` via `gotify_tag` (currently `2.2.5`) - https://github.com/gotify/server/releases

## Known upgrade constraints

None documented yet.

## Other notes

This service being down breaks notifications for everything else - treat upgrades cautiously and verify a test message still delivers afterward.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

