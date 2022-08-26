#!/bin/bash
# check coldplay tickets availability in seetickets.com

# (*) https://apps.apple.com/cn/app/bark-%E7%BB%99%E4%BD%A0%E7%9A%84%E6%89%8B%E6%9C%BA%E5%8F%91%E6%8E%A8%E9%80%81/id1403753865
barkId="null"
eventsUrl="""https://www.seetickets.com/event/coldplay-music-of-the-spheres-world-tour/etihad-stadium/2398039
https://www.seetickets.com/event/coldplay-music-of-the-spheres-world-tour/etihad-stadium/2398037
https://www.seetickets.com/event/coldplay-music-of-the-spheres-world-tour/etihad-stadium/2398033
https://www.seetickets.com/event/coldplay-music-of-the-spheres-world-tour/etihad-stadium/2398038"""

echo "$eventsUrl" > eventsUrl.txt

while :; do

cat eventsUrl.txt | while read url; do

echo "Checking ticket availability at $url"

curl "$url" --compressed --progress-bar > tmp.html

responseContinueButtonCount=`cat tmp.html | grep -c 'buy-tickets-button__text'`

if [[ $responseContinueButtonCount -gt 0 ]]; then
    echo "Congratulations, find available tickets!"
    echo "$url"
    curl "https://api.day.app/$barkId/Tickets Avaliable at $url/"
    exit 0
fi

echo "-.- Not lucky enough, sleep 5 seconds and retry the next date..."
sleep 5

done

echo "-.- Not lucky enough, all dates un-avaliable, sleep 35 seconds and retry the next round..."
sleep 35

done
