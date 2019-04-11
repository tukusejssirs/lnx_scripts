# This function outputs six spaces which has the background colour set to hex colour input on the command line

# There can be multiple colour codes, but all must be in hex format, case insensitive and without the hash/pound sign (#)

# author:  Tukusej's Sirs
# date:    11 April 2019
# version: 1.0

hexcol(){
	perl -e 'foreach $a(@ARGV){print "\e[48;2;".join(";",unpack("C*",pack("H*",$a)))."m      \e[49m "};print "\n"' "$@"
}