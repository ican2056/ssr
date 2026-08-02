#!/bin/bash
set -e

DROPBEAR_DIR=/tmp/dropbear
DROPBEAR_RSA_KEY="$DROPBEAR_DIR/dropbear_rsa_host_key"
DROPBEAR_ECDSA_KEY="$DROPBEAR_DIR/dropbear_ecdsa_host_key"
DROPBEAR_PID="$DROPBEAR_DIR/dropbear.pid"

mkdir -p "$DROPBEAR_DIR"
umask 077

if [ ! -s "$DROPBEAR_ECDSA_KEY" ]; then
    echo "Generating Dropbear ECDSA host key..."
    dropbearkey -t ecdsa -s 256 -f "$DROPBEAR_ECDSA_KEY"
fi

if [ ! -s "$DROPBEAR_RSA_KEY" ]; then
    echo "Generating Dropbear RSA host key..."
    dropbearkey -t rsa -s 2048 -f "$DROPBEAR_RSA_KEY"
fi

rm -f "$DROPBEAR_PID"

echo "Starting Dropbear on 127.0.0.1:22..."

/usr/sbin/dropbear \
    -F \
    -E \
    -p 127.0.0.1:22 \
    -P "$DROPBEAR_PID" \
    -r "$DROPBEAR_ECDSA_KEY" \
    -r "$DROPBEAR_RSA_KEY" &

DROPBEAR_PROCESS=$!

sleep 1

if ! kill -0 "$DROPBEAR_PROCESS" 2>/dev/null; then
    echo "Dropbear failed to start"
    exit 1
fi

echo "Dropbear started, PID=$DROPBEAR_PROCESS"

exec java -cp .:./lib/netty-all-4.1.42.Final.jar RemoteProxy
