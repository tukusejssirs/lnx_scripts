# Format and colours variables definition
# Note: not every terminal emulator supports all of them

# terminal colour definitions
# ===========================
#
# name     : hex    : rrr ggg bbb
# ---------:--------:-------------
# black    : 000000 :   0   0   0
# dgrey    : 555555 :  85  85  85
# red      : aa0000 : 170   0   0
# green    : 00aa00 :   0 170   0
# yellow   : aa5500 : 170  85   0
# blue     : 030537 :   3   5  55
# magenta  : aa00aa : 170   0 170
# cyan     : 00aaaa :   0 170 170
# lgrey    : aaaaaa : 170 170 170
# lred     : ff5555 : 255  85  85
# lgreen   : 55ff55 :  85 255  85
# lyellow  : ffff55 : 255 255  85
# lblue    : 5555ff :  85  85 255
# lmagenta : ff55ff : 255  85 255
# lcyan    : 55ffff :  85 255 255
# white    : ffffff : 255 255 255

# Format
#bold="\e[1m"  # This is either bold (if supported) or bright in colour
#dim="\e[2m"
#italics="\e[3m"
#underline="\e[4m"
#blink="\e[5m"
#overline="\e[6m"
#invert="\e[7m"  # Invert the foreground and background colours
#hide="\e[8m"  # Change foreground to background colour
#strike="\e[9m"  # Strikethrough

# Format and colour reseting
#unbold="\e[21m"
#undim="\e[22m"
#unitalics="\e[23m"
#ununderline="\e[24m"
#unblink="\e[25m"
#unoverline="\e26m"
#uninvert="\e[27m"
#unhide="\e[28m"
#unstrike="\e[9m"
#normal="\e[0"  # Normal format (i.e reset all manually set format)
set fdefault (set_color normal)
#bdefault="\e[49m"  # Default background colour

# Foreground colours (8/16)
set black (set_color black)
set red (set_color red)
set green (set_color green)
set yellow (set_color yellow)
set blue (set_color blue)
set magenta (set_color magenta)
set cyan (set_color cyan)
set lgrey (set_color white)
set dgrey (set_color brblack)
set lred (set_color brred)
set lgreen (set_color brgreen)
set lyellow (set_color bryellow)
set lblue (set_color brblue)
set lmagenta (set_color brmagenta)
set lcyan (set_color brcyan)
set white (set_color brwhite)

# Background colours (8/16)
set bblack (set_color -b black)
set bred (set_color -b red)
set bgreen (set_color -b green)
set byellow (set_color -b yellow)
set bblue (set_color -b blue)
set bmagenta (set_color -b magenta)
set bcyan (set_color -b cyan)
set blgrey (set_color -b white)
set bdgrey (set_color -b brblack)
set blred (set_color -b brred)
set blgreen (set_color -b brgreen)
set blyellow (set_color -b bryellow)
set blblue (set_color -b brblue)
set blmagenta (set_color -b brmagenta)
set blcyan (set_color -b brcyan)
set bwhite (set_color -b brwhite)
