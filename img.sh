#!/bin/bash
# https://github.com/Ceryn/img

clientid='3e7a4deb7ac67da'
img=$(date '+/tmp/%N.png')

scrot -zs $img >/dev/null 2>&1 || exit
res=$(curl -sH "Authorization: Client-ID $clientid" -F "image=@$img" "https://api.imgur.com/3/upload")

echo $res | egrep -qo '"status":200' && link=$(echo $res | sed -e 's/.*"link":"\([^"]*\).*/\1/' -e 's/\\//g')
test -n "$link" && (printf $link | xclip; printf "\a") || echo "$res" > "$img.error"
