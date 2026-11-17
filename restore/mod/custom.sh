#!/bin/sh
# mib2q-carplay 1.5: remove custom insets and use built-in geometry.
set -eu
PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/armle/bin:/mnt/app/armle/usr/bin
export PATH
unset LD_PRELOAD

case $0 in */*) D=${0%/*} ;; *) D=. ;; esac
D=$(cd "$D" && pwd)
if [ ! -d /mnt/app/eso/hmi/lsd ] && [ -d /net/mmx/mnt/app/eso/hmi/lsd ]; then
    exec on -f mmx /bin/sh "$D/custom.sh" "$@"
fi

F=/mnt/app/root/aa_cluster.insets
mount -uw /mnt/app 2>/dev/null || :
rm -f "$F"
sync
echo "DONE. $F removed (if present)."
echo "Reconnect the phone to use the built-in insets."
