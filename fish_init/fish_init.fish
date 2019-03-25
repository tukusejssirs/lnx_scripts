#!/usr/bin/fish

# Variables
set script_dir (realpath (dirname (status -f)))
set fish_config_dir "$HOME/.config/fish"

if [ (echo $script_dir | grep -o lnx_scripts) ]
	set lnx_scripts_dir (echo $script_dir | sed 's/\(lnx_scripts\)\/.*$/\1/' -)
else
	set lnx_scripts_dir "$HOME/git/lnx_scripts"
end

if [ "$fish_config_dir" ]
	mv $fish_config_dir{,.bak}
end

ln -s $lnx_scripts_dir/fish_config $fish_config_dir