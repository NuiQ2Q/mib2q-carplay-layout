#!/bin/sh
# M.I.B. custom action: write Android Auto cluster insets.
set -u
PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/armle/bin:/mnt/app/armle/usr/bin
export PATH
unset LD_PRELOAD

case $0 in */*) D=${0%/*} ;; *) D=. ;; esac
D=$(cd "$D" && pwd) || exit 1

echo "AA INSETS: START"

if [ ! -d /mnt/app/eso/hmi/lsd ]; then
    if [ -d /net/mmx/mnt/app/eso/hmi/lsd ]; then
        echo "AA INSETS: switching to MMX"
        on -f mmx /bin/sh "$D/custom.sh" "$@" 2>&1
        RC=$?
        if [ "$RC" -ne 0 ]; then
            echo "AA INSETS: ERROR - MMX script returned $RC"
        fi
        exit "$RC"
    fi
    echo "AA INSETS: ERROR - MMX application directory not found"
    exit 1
fi

F=/mnt/app/root/aa_cluster.insets
if [ ! -d /mnt/app/root ]; then
    echo "AA INSETS: ERROR - /mnt/app/root is absent"
    exit 1
fi

if ! mount -uw /mnt/app 2>&1; then
    echo "AA INSETS: remount failed; checking by writing the file"
fi
if ! cat > "$F" <<'EOF'
47 166 130 290
47 166 510 510
58 166 484 394
EOF
then
    echo "AA INSETS: ERROR - cannot write $F"
    exit 1
fi
if ! chmod 644 "$F" 2>&1; then
    echo "AA INSETS: ERROR - cannot set permissions on $F"
    exit 1
fi
if ! sync 2>&1; then
    echo "AA INSETS: ERROR - sync failed"
    exit 1
fi

echo "AA INSETS: file contents:"
if ! cat "$F"; then
    echo "AA INSETS: ERROR - cannot read back $F"
    exit 1
fi
echo "AA INSETS: DONE - $F written"
echo "Reconnect the phone to apply."
