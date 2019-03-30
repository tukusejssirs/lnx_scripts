#!/usr/bin/fish

# TODO
# - make it a function
# - use gettopts

# Options
set cd_only_one_arg "true"
#set sed_options "-i"

# Convert aliases to functions
# - each alias on separate line
# - may be followed by a comment
sed $sed_options "s/^\([ \t]*\)alias \([^=]*\)=['\"]\([^'\"].*\)[\"']\([ ]*[#]*.*\)\$/\1function \2\4\n\1\t\3 \$argv\n\1end/" $argv

# Remove "$argv" from cd command if cd_only_on4_arg is set to "true"
# TODO: not working yet
sed $sed_options 's/cd \([^ ]*\) \$argv/cd \1/g' $argv
sed $sed_options 's/cd \(["]\(.*\)["]\) \$argv/cd \1/g' $argv
sed $sed_options "s/cd \([']\(.*\)[']\) \$argv/cd \1/g" $argv