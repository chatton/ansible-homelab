# portainer_uptime_kuma

## Purpose

Deploys Uptime Kuma, the homelab's uptime/status-check monitoring dashboard.

## Managed image(s)

- `louislam/uptime-kuma` via `uptime_kuma_tag` (currently `2.0.0`) - https://github.com/louislam/uptime-kuma/releases

## Known upgrade constraints

Upgrading from v1 to v2 is a major version change with breaking changes. DO NOT skip v2.0 - migrate to v2.0.0 first, then update to later v2.x versions. The migration involves automatic database schema changes that can take significant time (7+ minutes for small instances, potentially hours for large ones).

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-24: Uptime Kuma `1.22.0` → `2.0.0` (major version upgrade), PR #114

