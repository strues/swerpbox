#!/usr/bin/env bash

cd ${0%/*}

usage() {
    echo "./buildall.sh [-n] [-q]"
    echo "  -n Do not use cache when building docker images"
    echo "  -q Quiet mode"
    exit 1
}

ARGS=

while getopts ":nq" opt; do
    case $opt in
        n) ARGS="$ARGS --no-cache" ;;
        q) ARGS="$ARGS --quiet" ;;
        \?) usage ;;
    esac
done

docker pull swerpbox/rutorrent &
docker build -t swerpbox/frontend $ARGS docker/frontend &
docker build -t swerpbox/deluge   $ARGS docker/deluge &
wait
