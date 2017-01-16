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

docker build -t swerpbox/rutorrent  $ARGS docker/rutorrent  &
docker build -t swerpbox/nginx      $ARGS docker/nginx      &

wait
