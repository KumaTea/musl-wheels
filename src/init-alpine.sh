#!/bin/sh

set -e -x

PWD=$(pwd)
WORKDIR="/home/kuma/musl"

MIRROR="mirrors.matrix.moe"

MUSL_MINOR=$(apk info musl | head -n 1 | awk -F'.' '{print $2}')

sed -i 's/dl-cdn.alpinelinux.org/$MIRROR/g' /etc/apk/repositories

apk add alpine-sdk bash ca-certificates cmake curl gettext git libffi-dev libjpeg-turbo-dev libpng-dev nano openssl-dev wget xz zlib-dev
apk add postgresql-dev libxml2-dev libxslt-dev unixodbc-dev freetds-dev
apk add hdf5-dev openblas-dev geos-dev rust rustup


NEWER_PKGS="apache-arrow-dev ninja-build samurai llvm14-dev"


if [ "$MUSL_MINOR" == "2" ]; then
  apk add $NEWER_PKGS
else
  echo $NEWER_PKGS | xargs -n 1 "$WORKDIR/try_install.sh"
fi

VERY_NEW_PKGS="librdkafka"

echo $VERY_NEW_PKGS | xargs -n 1 "$WORKDIR/try_install.sh"
