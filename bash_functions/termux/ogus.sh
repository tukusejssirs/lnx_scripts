# This script

# author:  Tukusej's Sirs
# version: 1.0
# date:    1 Feb 2019

# dependencies (Android):     termux termux-tasker tasker rooted_android bash_shell
# dependencies (Termux/Bash): sudo cat grep sed if curl jq wget echo reboot return

# TODO:
# - make it work without termux
# - create ogus_init.sh

# Install sudo if (1) not root and (2) running in termux and (3) no sudo installed; othewise try to use su, else fail
# git dl sudo
#ln -s $PWD/sudo /data/data/com.termux/files/usr/bin/sudo
#chmod 700 ./sudo /data/data/com.termux/files/usr/bin/sudo

#!/bin/bash
# Colour definitions
fdefault="\e[39m"  # Default format and colour
lred="\e[91m"      # Light red
lmagenta="\e[95m"  # Light magenta

echo -e "${lmagenta}Checking Open GApps configuration and version ...${fdefault}"
type=$(sudo cat /system/etc/g.prop | grep ro.addon.type | sed 's/^.*type=\(.*\)$/\1/' -)

if [[ $type == "gapps" ]]; then
	arch=$(sudo cat /system/etc/g.prop | grep arch | sed 's/^.*arch=\(.*\)$/\1/' -)
	sdk=$(sudo cat /system/etc/g.prop | grep sdk | sed 's/^.*sdk=\(.*\)$/\1/' -)
	platform=$(sudo cat /system/etc/g.prop | grep platform | sed 's/^.*platform=\(.*\)$/\1/' -)
	open_type=$(sudo cat /system/etc/g.prop | grep open_type | sed 's/^.*open_type=\(.*\)$/\1/' -)
	curVer=$(sudo cat /system/etc/g.prop | grep version | sed 's/^.*version=\(.*\)$/\1/' -)
	latVer=$(curl --silent "https://api.github.com/repos/opengapps/arm64/releases/latest" | jq -r .tag_name)

	if [[ $curVer < $latVer ]]; then
		echo -e "${lmagenta}Found newer version ($latVer).\nDownloading ...${fdefault}"
		wget -q -O /storage/emulated/0/dls/update.zip https://github.com/opengapps/$arch/releases/download/$latVer/open_gapps-$arch-$platform-$open_type-$latVer.zip

		echo -e "${lmagenta}Download complete.\nCreating Open Recovery Script and rebooting ...${fdefault}"
		# src: https://android.stackexchange.com/questions/67622/shell-script-to-reboot-into-recovery-and-install-zip
		sudo bash -c "echo -e 'install /storage/emulated/0/dls/update.zip\nreboot' > /cache/recovery/openrecoveryscript"
		sudo reboot recovery
	elif [[ $curVer == $latVer ]]; then
		echo -e "${lmagenta}Open GApps version $latVer is already the latest version, no need to update it.${fdefault}"
	else
		echo -e "${lred}ERROR: Something has happened: current and latest version cannot be compared.\n\ncurrent version = $curVer\nlatest version  = $latVer${fdefault}"
		exit 1
	fi
else
	echo -e "${lred}ERROR: This script only updates Open GApps. On current system, the Open GApps are not installed.${fdefault}"
	exit 2
fi
