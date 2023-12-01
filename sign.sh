#!/bin/sh
SSL=/Users/secwang/anaconda3/bin/openssl
SIGNATURE=$(printf "%s" "$1" | $SSL dgst -sha256 -hmac "$2" | awk '{print $2}')
printf "%s" "$SIGNATURE"

