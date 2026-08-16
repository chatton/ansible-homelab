# portainer_photoprism

## Purpose

Deploys PhotoPrism, self-hosted photo management with AI-based tagging.

## Managed image(s)

- `photoprism/photoprism` via `photoprism_tag` (currently `230615`) - https://github.com/photoprism/photoprism/releases

## Known upgrade constraints

PhotoPrism tags are date-stamped (`YYMMDD`), not semver - compare dates, and check PhotoPrism's own release notes for required re-indexing or migration steps after an upgrade.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

