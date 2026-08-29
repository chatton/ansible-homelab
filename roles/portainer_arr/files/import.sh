#!/bin/sh
# Radarr/Sonarr import script (useScriptImport / scriptImportPath).
# Invoked as: import.sh <source_path> <dest_path>, both already fully computed
# by Radarr/Sonarr (naming included) - this script only needs to place the
# file. GNU cp/mv fall back correctly on cross-filesystem copy_file_range
# EOPNOTSUPP (unlike the app's own bundled .NET runtime), which is the actual
# bug this works around - see roles/portainer_arr/CLAUDE.md.
set -eu
SRC="$1"
DST="$2"
mkdir -p "$(dirname "$DST")"
# Plain `mv` tries to preserve mode/ownership across the mergerfs (FUSE) boundary,
# which mergerfs doesn't support - it's harmless (mv still succeeds) but logs a
# spurious [Error] line in Radarr/Sonarr for every single import. cp --preserve=timestamps
# skips mode/ownership but keeps the original mtime, then rm cleans up the source.
cp --preserve=timestamps "$SRC" "$DST"
rm -f "$SRC"
