#/bin/bash
#curl --silent http://feeds.feedburner.com/Copacetic | grep -o '<enclosure url="[^"]*' | awk -F "\"" '{print $2}' | tail -1 > /tmp/podcast.now
#/home/pi/lcd.py "Copacetic" `cat /tmp/podcast.now | tail -c 21`
#mpg123 `cat /tmp/podcast.now` &
#cat podcast.db | tail -3 | awk -F "/" '{print $NF}'

curl --silent $@ | grep enclosure | grep -o 'url="[^"]*' | awk -F "\"" '{print $2}' | head -1 > /tmp/podcast.now
mpg123 `cat /tmp/podcast.now` &
