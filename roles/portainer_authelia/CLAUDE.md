# portainer_authelia

## Purpose

Deploys Authelia, a self-hosted authentication/SSO gateway used in front of other services.

## Managed image(s)

- `authelia/authelia` via `authelia_tag` (currently `4.38.9`) - https://github.com/authelia/authelia/releases

## Known upgrade constraints

Authelia config schema has changed across major versions before - read the release notes for breaking config changes before bumping, not just the version number.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-24: Authelia `4.37` → `4.38.9`, PR #113

