# portainer_arr

## Purpose

Deploys the *arr media-automation stack (Sonarr, Radarr, Lidarr, Jackett, qBittorrent) behind a ProtonVPN sidecar (`arr_vpn`). All the download-client/indexer/PVR pieces for the media library live here.

## Managed image(s)

- `ghcr.io/tprasadtp/protonwire` via `arr_vpn_tag` (currently `7.5.0`) - https://github.com/tprasadtp/protonvpn-docker/releases
- `lscr.io/linuxserver/qbittorrent` via `qbittorrent_tag` (currently `4.6.3`) - https://github.com/linuxserver/docker-qbittorrent/releases
- `lscr.io/linuxserver/radarr` via `radarr_tag` (currently `5.26.2.10099-ls281`) - https://docs.linuxserver.io/images/docker-radarr/
- `lscr.io/linuxserver/sonarr` via `sonarr_tag` (currently `4.0.15.2941-ls290`) - https://docs.linuxserver.io/images/docker-sonarr/
- `blampe/lidarr` via `lidarr_tag` (currently `latest`) - https://docs.linuxserver.io/images/docker-lidarr/
- `lscr.io/linuxserver/jackett` via `jackett_tag` (currently `0.21.2354`) - https://github.com/Jackett/Jackett/releases

## Known upgrade constraints

- `lidarr_tag` is currently `latest` (floating, unpinned) - this is a known open item. When pinning it, note the role also has `lidarr_image: lscr.io/linuxserver/lidarr` commented out in favor of `blampe/lidarr`; check whether the linuxserver.io image has since become viable again before switching back.
- linuxserver.io tags (`radarr`/`sonarr`/`qbittorrent`/`jackett`) use a vendor-specific scheme (`<app-version>-ls<build>`), not plain semver - compare the leading app version, not the whole string.
- **mergerfs import bug (fixed 2026-08-29 via a script hook, not a version pin) - read this before touching `sonarr_tag`/`radarr_tag`.** The version bump merged 2025-08-28 (commit `1148d61`) exposed a bug where both apps failed every completed download with `System.IO.IOException: Not supported`, thrown from the .NET runtime's `File.Move` -> `CopyFile` path when moving a file from `directories.downloads_dir` (`/mnt/ssd0`, ext4) to `directories.tv_dir`/`movies_dir` (`/mnt/mergerfs`, a FUSE mount) - the cross-filesystem copy hits `copy_file_range()` returning `EOPNOTSUPP` on the FUSE mount, and the runtime doesn't fall back to a plain read/write copy.
  - **Root cause, precisely identified 2026-08-29**: it is not an app-version or net6-vs-net8 issue - both the last known-working build (`radarr_tag: 5.3.6.8612-ls212`, bundles .NET runtime `6.0.25`) and the broken one (`5.26.2.10099-ls281`, bundles `6.0.35`) target `net6.0`; the regression is a `.NET 6.0.x` *runtime patch* Radarr's own release pipeline picked up somewhere between the two, unrelated to Radarr's app version. Confirmed via each build's `Radarr.runtimeconfig.json` (`includedFrameworks` version) and by diffing `Language.cs` across releases (see below) - every Radarr release with the runtime bundled runtime `6.0.35`+ already existed before Tagalog/Afrikaans language support was even added, so there is no released version that has both the old runtime and current language-table coverage. Don't waste time hunting for an "intermediate" app version - it doesn't exist.
  - **The actual fix**: enable Radarr/Sonarr's built-in `useScriptImport`/`scriptImportPath` hook (`config/mediamanagement`) with a small shell script (`roles/portainer_arr/files/import.sh`, bind-mounted read-only at `/scripts/import.sh` in both containers) that does the actual file placement via `cp --preserve=timestamps` + `rm` instead of the app's own internal move logic. GNU coreutils correctly falls back on `copy_file_range` `EOPNOTSUPP`/`EXDEV` (unlike this specific .NET patch), so this works around the bug without any app-version change - both apps stay on their current tags. `useScriptImport`/`scriptImportPath` are managed idempotently via `ansible.builtin.uri` in `tasks/main.yml` (GET then conditional PUT to `config/mediamanagement`) - the devopsarr Terraform providers for Radarr/Sonarr don't expose these two fields yet, and a generic REST provider would risk two independent writers fighting over the same singleton config object, so this stays in ansible rather than Terraform.
  - **Important operational finding**: this `IOException`, when unhandled inside `ImportApprovedMovie`/`UpgradeMediaFileService`, doesn't just fail one import - it crashes the whole Radarr/Sonarr process. s6-overlay (the container's PID 1 supervisor) silently respawns it, so this was easy to miss as "just a failed import" rather than a periodic full-app crash. After enabling the script fix, if `useScriptImport` is ever toggled again, restart the container afterward - `ConfigService`'s in-process cache is cleared correctly on a normal API/UI write, but a long-running command that started executing before the change (e.g. `ProcessMonitoredDownloads`) can get stuck indefinitely and block the command queue; a clean restart clears it.
  - Confirmed fixed 2026-08-29 against the real stuck-download backlog (72 movies queued since ~2026-08-19): manual imports succeed, backlog drains automatically afterward, zero new `IOException: Not supported` since the fix. `mergerfs` itself (upgraded 2.41.1 -> 2.42.0 on 2026-07-22) was investigated as an alternate cause and ruled out - the fix works with mergerfs unchanged.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-29: no version change - fixed the mergerfs import `IOException` (see "Known upgrade constraints" above) by adding `roles/portainer_arr/files/import.sh` + a new `/scripts` bind mount, and enabling `useScriptImport` on both Radarr and Sonarr via idempotent `ansible.builtin.uri` tasks in `tasks/main.yml`. `sonarr_tag`/`radarr_tag` remain unchanged (`4.0.15.2941-ls290` / `5.26.2.10099-ls281`) - both are behind latest upstream (`4.0.19.2979-ls322` / `6.3.0.10514-ls314` as of 2026-08-29) but that's an ordinary, unblocked version-bump decision now, unrelated to this fix.

