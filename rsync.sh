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
source .env  # NOTE: requires environment file, e.g. RSYNC_SRC_DEST="/media/shane/shane4tb/ shane4tb"
DATE=$(date -Ins)
read -p "Type a brief message associated with the log file: " MSG

mkdir -p .rsync_logs

rsync_cmd="$rsync_cmd $RSYNC_SRC_DEST"
FRIENDLY_RSYNC_CMD="$rsync_cmd 2>&1 | tee -a .rsync_logs/${real}output${DATE}_MSG:$MSG.txt"
printf "\\n\e[1;31m%s\e[0m\\n" "$FRIENDLY_RSYNC_CMD"
echo $FRIENDLY_RSYNC_CMD > .rsync_logs/${real}output${DATE}_MSG:$MSG.txt
bash -c "$rsync_cmd" 2>&1 | tee -a .rsync_logs/${real}output${DATE}_MSG:$MSG.txt
