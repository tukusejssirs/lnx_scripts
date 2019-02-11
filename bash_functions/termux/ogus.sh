#!/data/data/com.termux/files/usr/bin/bash
# This script can be used to check the latest version of OpenGApps, download latest version of them, automatically reboot to TWRP, install it and reboot back to Android again.

# It can be used in some kind of cronjob to make it fully automatic. I execute the script in Termux and via termux-tasker connect it to Tasker, in which I created a recurring task at 2am each day to execute this script.

# Btw, this is why I named this script as `ogus`: Open Gapps Update Script

# author:  Tukusej's Sirs
# version: 1.0
# date:    1 Feb 2019

# dependencies (Android):     termux termux-tasker tasker rooted_android su bash_shell
# dependencies (Termux/Bash): termux-sudo coreutils grep sed curl jq wget ncurses-utils

# TODO:
# - make it work without termux
# - create ogus_init.sh
# - create an after-boot-up script that would delete the update.zip

# Colour definitions
fdefault="\e[39m"  # Default format and colour
lred="\e[91m"      # Light red
lmagenta="\e[95m"  # Light magenta

echo -e "${lmagenta}Checking Open GApps configuration and version ...${fdefault}"
type=$(sudo cat /system/etc/g.prop | grep ro.addon.type | sed 's/^.*type=\(.*\)$/\1/' -)

if [[ "$type" == "gapps" ]]; then
	arch=$(sudo cat /system/etc/g.prop | grep arch | sed 's/^.*arch=\(.*\)$/\1/' -)
	sdk=$(sudo cat /system/etc/g.prop | grep sdk | sed 's/^.*sdk=\(.*\)$/\1/' -)
	platform=$(sudo cat /system/etc/g.prop | grep platform | sed 's/^.*platform=\(.*\)$/\1/' -)
	open_type=$(sudo cat /system/etc/g.prop | grep open_type | sed 's/^.*open_type=\(.*\)$/\1/' -)
	curVer=$(sudo cat /system/etc/g.prop | grep version | sed 's/^.*version=\(.*\)$/\1/' -)
	latVer=$(curl --silent "https://api.github.com/repos/opengapps/$arch/releases/latest" | jq -r .tag_name)

	if [[ $curVer < $latVer ]]; then
		echo -e "${lmagenta}Found newer version ($latVer).\nDownloading ...${fdefault}"
		wget -q -O /storage/emulated/0/dls/update.zip https://github.com/opengapps/$arch/releases/download/$latVer/open_gapps-$arch-$platform-$open_type-$latVer.zip

		echo -e "${lmagenta}Download complete.\nCreating Open Recovery Script and rebooting ...${fdefault}"
		sudo bash -c "echo -e 'install /storage/emulated/0/dls/update.zip\nrm /storage/emulated/0/dls/update.zip\nreboot' > /cache/recovery/openrecoveryscript"
		#sudo reboot recovery
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
