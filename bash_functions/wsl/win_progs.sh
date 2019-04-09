# This file contains all functions/aliases that make it possible to run MS Windows apps from WSL Bash

# author:  Tukusej's Sirs
# date:    4 April 2019
# version: 1.2

if [ -e /mnt/c/Program\ Files/Adobe/Adobe\ InDesign\ CC\ 2018/InDesign.exe ]; then
	function indesign(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Adobe/Adobe\ InDesign\ CC\ 2018/InDesign.exe "$file"
		alias indi="indesign"
	}
fi
if [ -e /mnt/c/Program\ Files/Adobe/Adobe\ Photoshop\ CC\ 2018/Photoshop.exe ]; then
	function photoshop(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Adobe/Adobe\ Photoshop\ CC\ 2018/Photoshop.exe "$file"
	}
fi
if [ -e /mnt/c/Program\ Files/FileZilla\ FTP\ Client/filezilla.exe ]; then
	function filezilla(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/FileZilla\ FTP\ Client/filezilla.exe "$file"
		alias fz="filezilla"
	}
fi
if [ -e /mnt/c/Program\ Files/GIMP\ 2/bin/gimp-[0-9.]*.exe ]; then
	function gimp(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/GIMP\ 2/bin/gimp-[0-9.]*.exe "$file"
	}
fi
if [ -e /mnt/c/Program\ Files/Microsoft\ Office/root/Office16/WINWORD.EXE ]; then
	function msword(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/WINWORD.EXE "$file"
		alias word="msword"
	}
fi
if [ -e /mnt/c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.EXE ]; then
	function msexcel(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.EXE "$file"
		alias excel="msexcel"
	}
fi
if [ -e /mnt/c/Program\ Files/Microsoft\ Office/root/Office16/POWERPNT.EXE ]; then
	function mspowerpoint(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/POWERPNT.EXE "$file"
		alias powerpoint="mspowerpoint"
		alias pp="mspowerpoint"
		alias mspp="mspowerpoint"
	}
fi
if [ -e /mnt/c/Program\ Files/Microsoft\ Office/root/Office16/SETLANG.EXE ]; then
	function msolang(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/SETLANG.EXE "$file"
	}
fi
if [ -e /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe ]; then
	function firefox(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe "$file"
		alias ff="firefox"
	}
fi
if [ -e /mnt/c/Program\ Files/nomacs/bin/nomacs.exe ]; then
	function nomacs(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/nomacs/bin/nomacs.exe "$file"
	}
fi
if [ -e /mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe ]; then
	function subl(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe "$file"
	}
fi
function transmission-qt(){
	file=$(wslpath -aw $1)
	/mnt/c/Program\ Files/Transmission/transmission-qt.exe "$file"
		alias transmission="transmission-qt"
}
if [ -e /mnt/c/Program\ Files/VideoLAN/VLC/vlc.exe ]; then
	function vlc(){
		local file=$(wslpath -aw $1)
		/mnt/c/Program\ Files/VideoLAN/VLC/vlc.exe "$file"
	}
fi
alias cmd="cmd.exe"