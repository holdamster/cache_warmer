#!/usr/bin/bash

#delete older than 1 day
find /root/cache-warmup/tmp/ -type f -mtime +1 -exec rm -rf {} \;

#USERAGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15"
USERAGENT="CACHE WARMER"
if [ "$#" -ne 1 ] || [ "x$1" == "x" ] ; then 
    echo "Usage: $0 <sitemap.xml>"
    exit 0;
fi

if [ ! -f "$1" ]; then 
    echo "Sitemap file $1 not found! Exit!"
    exit 1
fi

#cat "$1" | perl -ne 'while (/>(http.+?)</g) { print "$1\n"; }' | while read line; do 

cat "$1" | while read line; do
	LICZBA=$RANDOM
	TIMESTAMP=`date +%Y-%m-%d_%H:%M:%S:%N`

#curl -so /dev/null -w "%{time_connect} - %{time_starttransfer} - %{time_total}  " $line

	echo -e "$line\n" >> /root/cache-warmer/tmp/$LICZBA
	curl -A "$USERAGENT" -so /dev/null -w "@/root/cache-warmer/curl-format.txt" $line >> /root/cache-warmup/tmp/$LICZBA

	ADDRESS=`grep -i anetarzodeczko.pl /root/cache-warmer/tmp/$LICZBA`
	TIME_NAMELOOKUP=`grep -i time_namelookup /root/cache-warmer/tmp/$LICZBA | awk '{print $2}'`
	TIME_CONNECT=`grep -i time_connect /root/cache-warmer/tmp/$LICZBA	| awk '{print $2}'`
	TIME_APPCONNECT=`grep -i time_appconnect /root/cache-warmer/tmp/$LICZBA	| awk '{print $2}'`
	TIME_PRETRANSFER=`grep -i time_pretransfer /root/cache-warmer/tmp/$LICZBA	| awk '{print $2}'`
	TIME_REDIRECT=`grep -i time_redirect /root/cache-warmer/tmp/$LICZBA	| awk '{print $2}'`
	TIME_STARTTRANSFER=`grep -i time_starttransfer /root/cache-warmer/tmp/$LICZBA	| awk '{print $2}'`
	TIME_TOTAL=`grep -i time_total /root/cache-warmer/tmp/$LICZBA	| awk '{print $2}'`

	mysql -D stats -e "INSERT INTO gabinet (address, id, timestamp, time_namelookup, time_connect, time_appconnect, time_pretransfer, time_redirect, time_starttransfer, time_total) VALUES ('$ADDRESS', NULL, current_timestamp(), '$TIME_NAMELOOKUP', '$TIME_CONNECT', '$TIME_APPCONNECT', '$TIME_PRETRANSFER', '$TIME_REDIRECT', '$TIME_STARTTRANSFER', '$TIME_TOTAL');"

done
