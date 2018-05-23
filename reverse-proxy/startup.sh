#!/usr/bin/env sh
set -ex

#Reload nginx on key/certificate change
inotifyd /reload.sh /ssl/fullchain.cer:c &
inotifyd /reload.sh /ssl/site.key:c &

exec nginx -g 'daemon off;'
