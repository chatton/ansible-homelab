# portainer_diun

## Purpose

Deploys Diun, which watches running container images for new upstream tags and notifies via Gotify. This *complements* the nightly maintenance agent (it just notifies; it never edits this repo) - don't confuse the two.

## Managed image(s)

- `crazymax/diun` via `diun_tag` (currently `latest`) - https://github.com/crazy-max/diun/releases

## Known upgrade constraints

None documented yet.

## Other notes

`diun_tag` is currently `latest` (floating, unpinned) - a candidate for pinning.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

