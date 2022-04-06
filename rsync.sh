#!/bin/bash

cd "$(dirname "$0")"

rsync_cmd="rsync --archive --verbose"


# Determine if `--dry-run`
real=0
for var in "$@"
do
    if [[ $var == "--real" ]]; then
        real=1
    fi
done

if [[ $real == 0 ]]; then
    rsync_cmd="${rsync_cmd} --dry-run"
fi

# Determine if `--delete`
for var in "$@"
do
    if [[ $var == "--delete" ]]; then
        rsync_cmd="${rsync_cmd} --delete"
    fi
done

# Assign and run final command
source .rsync  # NOTE: requires .rsync environment file , e.g. RSYNC_SRC_DEST="/media/shane/shane4tb/ shane4tb"
rsync_cmd="$rsync_cmd $RSYNC_SRC_DEST"
printf "\\n\e[1;31m%s\e[0m\\n" "$rsync_cmd"

$rsync_cmd
