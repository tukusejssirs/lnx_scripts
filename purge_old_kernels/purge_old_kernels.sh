#!/bin/sh
#
#    purge-old-kernels - remove old kernel packages
#    Copyright (C) 2012 Dustin Kirkland <kirkland@ubuntu.com>
#
#    Authors: Dustin Kirkland <kirkland@ubuntu.com>
#             Kees Cook <kees@ubuntu.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, version 3 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Ensure we're running as root
if [ "$(id -u)" != 0 ]; then
	echo "ERROR: This script must run as root.  Hint..." 1>&2
	echo "  sudo $0 $@" 1>&2
	exit 1
fi

# NOTE: This script will ALWAYS keep the currently running kernel
# NOTE: Default is to keep 2 more, user overrides with --keep N
KEEP=2
# NOTE: This script will give a hint if no kernels are eligible for removal
# NOTE: You can disable this with the --quiet parameter
QUIET=0
# NOTE: Any unrecognized option will be passed straight through to apt
APT_OPTS=
while [ ! -z "$1" ]; do
	case "$1" in
		--quiet)
			# No hint on no kernels for removal, better for cronjobs
			QUIET=1
			shift 1
		;;
		--keep)
			# User specified the number of kernels to keep
			KEEP="$2"
			shift 2
		;;
		*)
			APT_OPTS="$APT_OPTS $1"
			shift 1
		;;
	esac
done

# Build our list of kernel packages to purge, make sure we exclude the current running kernel
current="$(uname -r)"
VERSIONS=$(ls -f /boot/vmlinuz-* | grep -v "$current$" | grep -v '.efi.signed' | sed -e "s/[^\-]*-//" -e "s/-[^\-]*$//" | sort -rh)
count=0
for v in $VERSIONS; do
	count=$((count+1))
	if [ $count -le $KEEP ]; then
		continue
	fi
	for k in linux-image linux-headers linux-signed-image linux-image-virtual; do
		for f in generic lowlatency; do
			dpkg-query -s "$k-$v-$f" >/dev/null 2>&1 && PURGE="$PURGE $k-$v-$f"
		done
	done
done

if [ -z "$PURGE" ]; then
        if [ "${QUIET}" -ne "1" ]; then
                echo "No kernels are eligible for removal"
                exit 0
        else
                exit 0
        fi
fi

# Use apt-get, rather than apt, for compatibility with precise/trusty
if ! apt-get install --fix-broken --dry-run >/dev/null 2>&1; then
	echo "APT is broken, trying with dpkg"
	dpkg --purge $PURGE
	apt-get install --fix-broken
fi
apt-get remove $APT_OPTS --purge $PURGE
apt-get autoremove $APT_OPTS --purge