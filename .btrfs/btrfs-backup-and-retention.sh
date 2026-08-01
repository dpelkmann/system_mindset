#!/bin/bash
set -euo pipefail

BACKUP_MOUNT="/mnt/c1f11c8d-6f77-426c-aca6-295b08380de5"
KEEP=10
LOG="/var/log/btrfs-backup-and-retention.log"
LOCK="/var/lock/btrfs-backup-and-retention.lock"

log() {
  printf '[%s] %s\n' "$(date '+%F %T')" "$*" | tee -a "$LOG"
}

get_latest_snapshot() {
  local path="$1"
  ls -1 "$path" | sort -n | tail -n 1
}

do_backup() {
  local src_snapshots="$1"
  local dst_path="$2"
  local label="$3"

  mkdir -p "$dst_path"

  # Remove leftover temp snapshot from aborted receive
  if [ -d "$dst_path/snapshot" ]; then
    log "[$label] Removing leftover temporary snapshot: $dst_path/snapshot"
    rm -rf "$dst_path/snapshot"
  fi

  local latest
  latest=$(get_latest_snapshot "$src_snapshots" || true)

  if [ -z "$latest" ]; then
    log "[$label] No snapshots found in $src_snapshots, skipping"
    return
  fi

  local latest_src="$src_snapshots/$latest/snapshot"
  if [ ! -d "$latest_src" ]; then
    log "[$label] Latest snapshot missing: $latest_src"
    return
  fi

  local prev
  prev=$(ls -1 "$dst_path" | sort -n | tail -n 1 || true)

  log "[$label] latest=$latest prev=${prev:-none}"

  # No new snapshot → skip
  if [ -n "$prev" ] && [ "$latest" = "$prev" ]; then
    log "[$label] No new snapshot, skipping"
    return
  fi

  # Decide incremental vs full
  local use_parent=false
  local parent_src=""

  if [ -n "$prev" ]; then
    parent_src="$src_snapshots/$prev/snapshot"
    if [ -d "$parent_src" ]; then
      use_parent=true
      log "[$label] Using incremental parent: $parent_src"
    else
      log "[$label] Parent missing on source → full send"
    fi
  fi

  # Perform send
  if $use_parent; then
    log "[$label] Incremental send: -p $parent_src → $latest_src"
    if ! btrfs send -p "$parent_src" "$latest_src" | btrfs receive "$dst_path"; then
      log "[$label] Incremental failed → full send fallback"
      btrfs send "$latest_src" | btrfs receive "$dst_path"
    fi
  else
    log "[$label] Full send: $latest_src"
    btrfs send "$latest_src" | btrfs receive "$dst_path"
  fi

  # Rename received snapshot
  if [ -d "$dst_path/snapshot" ]; then
    mv "$dst_path/snapshot" "$dst_path/$latest"
    log "[$label] Received snapshot renamed to $dst_path/$latest"
  fi
}

cleanup_subvolume() {
  local path="$1"
  local label="$2"

  mkdir -p "$path"
  local snapshots
  mapfile -t snapshots < <(ls -1 "$path" | sort -n || true)

  local count=${#snapshots[@]}
  if ((count <= KEEP)); then
    log "[$label] Nothing to delete (count=$count)"
    return
  fi

  local delete_count=$((count - KEEP))
  log "[$label] Deleting $delete_count old snapshots"

  for ((i = 0; i < delete_count; i++)); do
    local old="${snapshots[$i]}"
    local old_path="$path/$old"
    log "[$label] Deleting $old_path"
    btrfs subvolume delete "$old_path"
  done
}

main() {
  exec 200>"$LOCK"
  flock -n 200 || {
    log "Another instance is running, exiting"
    exit 1
  }

  log "=== Backup+Retention Start ==="

  mkdir -p "$BACKUP_MOUNT/root" "$BACKUP_MOUNT/home"

  if ! mountpoint -q "$BACKUP_MOUNT"; then
    log "ERROR: $BACKUP_MOUNT is not mounted"
    exit 1
  fi

  log "Mount options: $(findmnt -no OPTIONS "$BACKUP_MOUNT")"

  do_backup "/.snapshots" "$BACKUP_MOUNT/root" "root"
  do_backup "/home/.snapshots" "$BACKUP_MOUNT/home" "home"

  cleanup_subvolume "$BACKUP_MOUNT/root" "root"
  cleanup_subvolume "$BACKUP_MOUNT/home" "home"

  log "=== Backup+Retention Finished ==="
}

main "$@"
