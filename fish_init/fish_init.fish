#!/usr/bin/fish

# Variables
set script_dir (realpath (dirname (status -f)))
set fish_functions_dir "$HOME/.config/fish/functions"

if [ (echo $script_dir | grep -o lnx_scripts) ]
	set lnx_scripts_dir (echo $script_dir | sed 's/\(lnx_scripts\)\/.*$/\1/' -)
else
	set lnx_scripts_dir "$HOME/git/lnx_scripts"
end

if [ "$fish_functions_dir" ]
	mv $fish_functions_dir{,.bak}
end

ln -s $lnx_scripts_dir/fish_functions $fish_functions_dir