#!/data/data/com.termux/files/usr/bin/bash
# This script can be used to check the latest version of OpenGApps, download latest version of them, automatically reboot to TWRP, install it and reboot back to Android again.

# It can be used in some kind of cronjob to make it fully automatic. I execute the script in Termux and via termux-tasker connect it to Tasker, in which I created a recurring task at 2am each day to execute this script.

# Btw, this is why I named this script as `ogus`: Open Gapps Update Script

# author:  Tukusej's Sirs
# version: 1.5
# date:    19 April 2019

# dependencies (Android):     termux termux-tasker tasker rooted_android su bash_shell
# dependencies (Termux/Bash): termux-sudo coreutils grep sed curl wget ncurses-utils

# exit codes:
# 0 : Successfull run
# 1 : Something has happened: current and latest version cannot be compared.\n\ncurrent version = $curVer\nlatest version  = $latVer
# 2 : This script only updates Open GApps. On current system, the Open GApps are not installed.
# 3 : Incorrect or negative answer or you did not answer in time.
# 4 : No root binary is in the $PATH.
# 5 : Although $su_bin is accessible, you need give root permissions to Tasker, Termux and Termux:Boot.\nIf you use Magisk, you might need to do this to Termux:Boot in Superuser side menu of Magisk.

# TODO:
# - in progress: make it work without termux
# - workaround (remove before downloading): create an after-boot-up script that would delete the update.zip
# - in progress: check if the *zip in dls folder exists; if yes, dl its md5, verify it; if it matches, don't dl it again
#   - create functions: md5_test, dl_md5, dl_zip, dl_all (to remove duplicate code and make it more versatile)
#   - remake ogus as function
#     - make it accept parameters ($path; no_reboot; dl_only))
#   - create ogus_run.sh script
# - create help (parameter -h/--help)

# User-dependant variables
path="/sdcard/dls"  # Location of downloaded files
mkdir -p $path      # Make sure $path exists

# Colour definitions
fdefault="\e[39m"  # Default format and colour
lred="\e[91m"      # Light red
lmagenta="\e[95m"  # Light magenta
lyellow="\e[93m"   # Light yellow

# Check if we SuperUser permissions
if [[ $(which sudo &>/dev/null; echo $?) == "0" ]]; then
	su_bin=$(which sudo)
elif [[ $(which su  &>/dev/null; echo $?) == "0" ]]; then
	su_bin=$(which su)
else
	echo -e "${lred}ERROR: No root binary is in the $PATH.${fdefault}"
	exit 4
fi

su_test=$($su_bin ls /system/build.prop)
if [[ "$su_test" != "/system/build.prop" ]]; then
	echo -e "${lred}ERROR: Although $su_bin is accessible, you need give root permissions to Tasker, Termux and Termux:Boot.\nIf you use Magisk, you might need to do this to Termux:Boot in Superuser side menu of Magisk.-${fdefault}"
	exit 5
fi

echo -e "${lmagenta}Checking Open GApps configuration and version ...${fdefault}"
type=$($su_bin cat /system/etc/g.prop | grep ro.addon.type | sed 's/^.*type=\(.*\)$/\1/' -)

if [[ "$type" == "gapps" ]]; then
	arch=$($su_bin cat /system/etc/g.prop | grep -Po "^.*arch=\K.*$")
	sdk=$($su_bin cat /system/etc/g.prop | grep -Po "^.*sdk=\K.*$")
	platform=$($su_bin cat /system/etc/g.prop | grep -Po "^.*platform=\K.*$")
	open_type=$($su_bin cat /system/etc/g.prop | grep -Po "^.*open_type=\K.*$")
	curVer=$($su_bin cat /system/etc/g.prop | grep -Po "^.*version=\K.*$")
	latVer=$(curl -s "https://api.github.com/repos/opengapps/$arch/releases/latest" | grep -Po "^[\t ]*\"tag_name\": \"\K[0-9]*(?=\",$)")
	zip="open_gapps-$arch-$platform-$open_type-$latVer.zip"
	url="https://github.com/opengapps/$arch/releases/download/$latVer"

	if [[ $curVer < $latVer ]]; then
		echo -e "${lmagenta}Found newer version ($latVer).${fdefault}"
		if [[ -e $path/$zip ]]; then
			echo -e "${lmagenta}Found the file already downloaded.${fdefault}"
                	echo -en "${lmagenta}Checking MD5 hashes ... ${fdefault}"
			cd $path
			rm open_gapps*md5
                	wget -q --show-progress --progress=bar:force:noscroll $url/$zip.md5  # https://stackoverflow.com/a/52844708>
                	zip_md5=$(md5sum $zip)
                	cd $OLDPATH
                	md5_md5=$(cat $path/$zip.md5)
                	if [[ "$zip_md5" == "$md5_md5" ]]; then
                	        echo -e "${lmagenta}Done.${fdefault}"
                	else
                	        echo -e "${lyellow}\nWARNING: MD5 hashes does not match, see bellow.\n\nzip: $zip_md5\nmd5: $md5_md5\n\nDo you want to continue? You have 5 seconds to answer (*no | yes):${fdefault}"
				echo -en "${lmagenta}Downloading $zip ... ${fdefault}"
	                        cd $path
        	                rm -rf open_gapps*zip
                	        wget -q --show-progress --progress=bar:force:noscroll $url/$zip  # https://stackoverflo>                        cd $OLDPWD
                        	echo -e "${lmagenta}Done.${fdefault}"
				echo -en "${lmagenta}Checking MD5 hashes again ... ${fdefault}"
				cd $path
	                        zip_md5=$(md5sum $zip)
                                cd $OLDPATH
                                md5_md5=$(cat $path/$zip.md5)
                                if [[ "$zip_md5" == "$md5_md5" ]]; then
	                                echo -e "${lmagenta}Done.${fdefault}"
	                        else
	                        	echo -e "${lred}\nERROR: MD5 hashes does not match, see bellow.\n\nzip: $zip_md5\nmd5: $md5_md5\n\nDo you want to continue? You have 5 seconds to answer (*no | yes):${fdefault}"
	                        	read -t 5 ans
       	                                case $ans in
	                                        y|Y|yes|Yes|YES)
        		                                echo -e "${lyellow}WARNING: Ignoring MD5 mismatch.${fdefault}"
                                                ;;
                                                *)
                                                	echo -e "${lred}Incorrect or negative answer or you did not answer in time.${fdefault}"
                                                        exit 3
						;;
                                        esac
                                fi
	                        	                                                                                                                                                                                                                                                                                                                fi
                	fi
			echo -e "${lmagenta}Creating Open Recovery Script and rebooting ...${fdefault}"
                        $su_bin bash -c "echo -e 'install $path/$zip\nreboot' > /cache/recovery/openrecoveryscript"
#			$su_bin reboot recovery
			exit 0
		else
			echo -en "${lmagenta}Downloading ... ${fdefault}"
			cd $path
			rm -rf open_gapps*
			wget -q --show-progress --progress=bar:force:noscroll $url/$zip{.md5,}  # https://stackoverflow.com/a/52844708/3408342
			cd $OLDPWD
			echo -e "${lmagenta}Done.${fdefault}"

			echo -en "${lmagenta}Checking MD5 hashes ... ${fdefault}"
			cd $path
			zip_md5=$(md5sum $zip)
			cd $OLDPATH
			md5_md5=$(cat $path/$zip.md5)
			if [[ "$zip_md5" == "$md5_md5" ]]; then
				echo -e "${lmagenta}Done.${fdefault}"
			else
				echo -e "${lred}\nERROR: MD5 hashes does not match, see bellow.\n\nzip: $zip_md5\nmd5: $md5_md5\n\nDo you want to continue? You have 5 seconds to answer (*no | yes):${fdefault}"
				read -t 5 ans
				case $ans in
					y|Y|yes|Yes|YES)
						echo -e "${lyellow}WARNING: Ignoring MD5 mismatch.${fdefault}"
					;;
					*)
						echo -e "${lred}Incorrect or negative answer or you did not answer in time.${fdefault}"
						exit 3
					;;
				esac
			fi

			echo -e "${lmagenta}Creating Open Recovery Script and rebooting ...${fdefault}"
			$su_bin bash -c "echo -e 'install $path/$zip\nreboot' > /cache/recovery/openrecoveryscript"
#			$su_bin reboot recovery
			exit 0
		fi
	elif [[ $curVer == $latVer ]]; then
		echo -e "${lmagenta}Open GApps version ${lyellow}$latVer${lmagenta} is already the latest version, no need to update it.${fdefault}"
	else
		echo -e "${lred}ERROR: Something has happened: current and latest version cannot be compared.\n\ncurrent version = $curVer\nlatest version  = $latVer${fdefault}"
		exit 1
	fi
else
	echo -e "${lred}ERROR: This script only updates Open GApps. On current system, the Open GApps are not installed.${fdefault}"
	exit 2
fi