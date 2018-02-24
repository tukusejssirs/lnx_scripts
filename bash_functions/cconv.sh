# This non-interactive script converts any supported currency to any other supported currency (-ies) using fixer.io API (therefore it need an Internet connection).

# author: Tukusej's Sirs (based upon what I found on the Internet, http://fixer.io/ ... https://github.com/lecler-i/bash-currency-converter/blob/master/bcc.sh)
# created: 25 Feb 2018
# dependencies: awk bc case cut do done echo else esac return fi for if printf sed seq then tr wget
# version: 1.1

#!/bin/bash
function cconv(){
	return_code=0

	case $1 in
		''|*[!0-9.-]*) echo 'Error: First argument must be a number, but it is "$1".' && return 1 ;;
		*) sum=`printf "%1.4f" $1` ;;
	esac

	from=`echo $2 | tr '[:lower:]' '[:upper:]'`
	to=`echo $3 | tr '[:lower:]' '[:upper:]'`

	if [[ $from == $to ]]; then
		echo "Warning: The source currency equals the target one."
		echo $to $sum
		return 2
	fi

	if [[ -z $4 ]]; then
		date="latest"  # This will get the latest rates
	else
		date=$4
	fi

	[ $# -lt 3 ] && {
		echo "Usage: $0 sum source_currency target_currency[,target_currency] [date]";
		echo
		echo "sum               a number (positive/negative integer/float number)"
		echo "source_currency   a currency code (case insensitive; e.g. EUR or eur)"
		echo "target_currency   a currency code (case insentitive; e.g. EUR or eur)"
		echo "                  Note: You can enter multiple, comma-separated target currencies, e.g. `usd,gbp`."
		echo "date [optional]   date from which the rate should be obtained (for latest use `latest`, which is default)"
		echo "no-warning | nw [optional]"
		echo "                  do not show warnings (you can still catch it using return code, see below)"
		echo
		echo "Note that the date can be any date since 1st January 1999 up to current date (today) and it must be in the format yyyy-mm-dd."
		echo "Following currencies are supported:"
		echo "AUD BGN BRL CAD CHF CNY CZK DKK EUR GBP HKD HRK HUF IDR ILS INR ISK JPY KRW MXN MYR NOK NZD PHP PLN RON RUB SEK SGD THB TRY USD ZAR"
		echo
		echo "Return codes:"
		echo "0  success"
		echo "1  failure"
		echo "2  warning"

	    return 1;
	}

	data=`wget -o /dev/null -O - "https://api.fixer.io/$date?base=$from&symbols=$to"`

	case $data in
		'')
			echo "Error: No data received."
			echo
			echo "Possible reasons:"
			echo "- you have no Internet connection;"
			echo "- you've entered incorrect source_currency code;"
			echo "- you have not entered all required arguments."
			echo "- you have entered invalid date."
			return 1
			;;
		*rates\":[{][}][}])
			echo "Error: You have not entered a valid target currency."
			return 1
			;;
	esac

	# For multiple target currencies, we need to split the currencies
	currency_num=`echo $(echo $to | awk -F, '{print NF-1}') + 1 | bc`  # The number of commas plus one
	if [[ currency_num -eq 1 ]]; then  # Single target currency
		rate=`echo $data | sed "s/.*rates\":[{]\"$to\":\([0-9.]*\).*/\1/g" -`
		echo $to `echo $sum \* $rate | bc`
	else  # Multiple target currency
		for n in `seq 1 $currency_num`; do
			to_split=$(echo $to | cut -f $n -d,)  # Splitting $to into $to_arr

			if [[ $from == $to_split ]]; then
				echo "Warning: The source currency equals the target one."
				return_code=2
				echo $to_split $sum
			else
				rate=`echo $data | sed "s/.*$to_split\":\([0-9.]*\).*/\1/" -`
				echo $to_split `echo $sum \* $rate | bc`
			fi
		done
	fi

	return $return_code
}