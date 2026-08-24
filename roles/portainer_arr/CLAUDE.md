# portainer_arr

## Purpose

Deploys the *arr media-automation stack (Sonarr, Radarr, Lidarr, Jackett, qBittorrent) behind a ProtonVPN sidecar (`arr_vpn`). All the download-client/indexer/PVR pieces for the media library live here.

## Managed image(s)

- `ghcr.io/tprasadtp/protonwire` via `arr_vpn_tag` (currently `7.5.3`) - https://github.com/tprasadtp/protonvpn-docker/releases
- `lscr.io/linuxserver/qbittorrent` via `qbittorrent_tag` (currently `4.6.3`) - https://github.com/linuxserver/docker-qbittorrent/releases
- `lscr.io/linuxserver/radarr` via `radarr_tag` (currently `5.26.2.10099-ls281`) - https://docs.linuxserver.io/images/docker-radarr/
- `lscr.io/linuxserver/sonarr` via `sonarr_tag` (currently `4.0.15.2941-ls290`) - https://docs.linuxserver.io/images/docker-sonarr/
- `blampe/lidarr` via `lidarr_tag` (currently `latest`) - https://docs.linuxserver.io/images/docker-lidarr/
- `lscr.io/linuxserver/jackett` via `jackett_tag` (currently `0.21.2354`) - https://github.com/Jackett/Jackett/releases

## Known upgrade constraints

- `lidarr_tag` is currently `latest` (floating, unpinned) - this is a known open item. When pinning it, note the role also has `lidarr_image: lscr.io/linuxserver/lidarr` commented out in favor of `blampe/lidarr`; check whether the linuxserver.io image has since become viable again before switching back.
- linuxserver.io tags (`radarr`/`sonarr`/`qbittorrent`/`jackett`) use a vendor-specific scheme (`<app-version>-ls<build>`), not plain semver - compare the leading app version, not the whole string.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-24: ProtonWire `7.5.0` → `7.5.3`, PR #110

