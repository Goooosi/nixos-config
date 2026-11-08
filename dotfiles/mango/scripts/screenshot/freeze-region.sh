#!/usr/bin/env bash
# Usage: freeze-region.sh [file|clip|both]   (default: file)
mode="${1:-file}"
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"

pipe=$(mktemp -u).fifo
mkfifo "$pipe"

wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $pipe" &
wayfreeze_pid=$!

cleanup() {
  kill "$wayfreeze_pid" 2>/dev/null
  rm -f "$pipe"
}
trap cleanup EXIT

read -r < "$pipe"

geometry=$(slurp -d)
[[ -z "$geometry" ]] && exit 1

file="$dir/Screenshot $(date '+%Y-%m-%d %H%M%S').png"

case "$mode" in
  clip) grim -g "$geometry" - | wl-copy --type image/png ;;
  both) grim -g "$geometry" - | tee "$file" | wl-copy --type image/png ;;
  *)    grim -g "$geometry" "$file" ;;
esac
