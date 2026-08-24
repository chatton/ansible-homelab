# portainer_minio

## Purpose

Deploys MinIO, S3-compatible object storage.

## Managed image(s)

- `minio/minio` via `minio_tag` (currently `RELEASE.2024-12-18T13-15-44Z`) - https://github.com/minio/minio/releases

## Known upgrade constraints

MinIO tags are date-stamped release identifiers, not semver - there's no "major version" to reason about numerically. Compare release dates instead, and check MinIO's own release notes for breaking changes (MinIO has deprecated/removed features across releases before).

**Note:** The MinIO GitHub repository was archived on April 25, 2026. The project has transitioned to AIStor as the enterprise offering, though the open-source minio/minio Docker images continued receiving updates through at least September 2025. Future upgrades may require migration to AIStor or another S3-compatible storage solution.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-24: RELEASE.2023-06-29T05-12-28Z → RELEASE.2024-12-18T13-15-44Z - PR TBD

