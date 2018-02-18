#!/bin/bash

# Ensure we're running as root
# Src: I copied this from `purge_old_kernels.sh`
if [ "$(id -u)" != 0 ]; then
	echo "ERROR: This script must run as root.  Hint..." 1>&2
	echo "  sudo $0 $@" 1>&2
	exit 1
fi

path=$PWD
echo -e "#\!/bin/bash\nsudo $PWD/purge_old_kernels.sh --keep 2 -yq" | sed 's/\\//' - > /etc/cron.daily/purge_old_kernels