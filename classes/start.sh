#!/bin/bash
set -e

DROPBEAR_DIR=/tmp/dropbear
DROPBEAR_KEY="$DROPBEAR_DIR/dropbear_rsa_host_key"
DROPBEAR_PID="$DROPBEAR_DIR/dropbear.pid"

mkdir -p "$DROPBEAR_DIR"
umask 077

if [ ! -s "$DROPBEAR_KEY" ]; then
    echo "Generating Dropbear host key..."
    dropbearkey -t rsa -f "$DROPBEAR_KEY"
fi

rm -f "$DROPBEAR_PID"

echo "Starting Dropbear on 127.0.0.1:22..."

/usr/sbin/dropbear \
    -F \
    -E \
    -p 127.0.0.1:22 \
    -P "$DROPBEAR_PID" \
    -r "$DROPBEAR_KEY" &

DROPBEAR_PROCESS=$!

sleep 1

if ! kill -0 "$DROPBEAR_PROCESS" 2>/dev/null; then
    echo "Dropbear failed to start"
    exit 1
fi

echo "Dropbear started, PID=$DROPBEAR_PROCESS"

exec java -cp .:./lib/netty-all-4.1.42.Final.jar RemoteProxy
