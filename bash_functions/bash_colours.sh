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
# blue     : 0000aa :   0   0 170
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
bold="\e[1m"  # This is either bold (if supported) or bright in colour
dim="\e[2m"
italics="\e[3m"
underline="\e[4m"
blink="\e[5m"
overline="\e[6m"
invert="\e[7m"  # Invert the foreground and background colours
hide="\e[8m"  # Change foreground to background colour
strike="\e[9m"  # Strikethrough

# Format and colour reseting
unbold="\e[21m"
undim="\e[22m"
unitalics="\e[23m"
ununderline="\e[24m"
unblink="\e[25m"
unoverline="\e26m"
uninvert="\e[27m"
unhide="\e[28m"
unstrike="\e[9m"
normal="\e[0"  # Normal format (i.e reset all manually set format)
fdefault="\e[39m"  # Default foreground colour
bdefault="\e[49m"  # Default background colour

# Foreground colours (8/16)
black="\e[30m"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
magenta="\e[35m"
cyan="\e[36m"
lgrey="\e[37m"
dgrey="\e[90m"
lred="\e[91m"
lgreen="\e[92m"
lyellow="\e[93m"
lblue="\e[94m"
lmagenta="\e[95m"
lcyan="\e[96m"
white="\e[97m"

# Background colours (8/16)
bblack="\e[40m"
bred="\e[41m"
bgreen="\e[42m"
byellow="\e[43m"
bblue="\e[44m"
bmagenta="\e[45m"
bcyan="\e[46m"
blgrey="\e[47m"
bdgrey="\e[100m"
blred="\e[101m"
blgreen="\e[102m"
blyellow="\e[103m"
blblue="\e[104m"
blmagenta="\e[105m"
blcyan="\e[106m"
bwhite="\e[107m"