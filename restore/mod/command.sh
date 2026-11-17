#!/bin/sh
# M.I.B. Run individual script / Run Custom Script compatibility.
case ${0##*/} in
    command.sh) exec /bin/sh "${0%/*}/custom.sh" "$@" ;;
esac
