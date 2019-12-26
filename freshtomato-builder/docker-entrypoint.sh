#!/bin/bash

# Setup timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone

export PATH="$PATH:/work/freshtomato-arm/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin"

git clone "$GIT_URL"

git checkout "$TARGET"

IMAGES_DIR=/work/freshtomato-arm/release/src-rt-6.x.4708/image

case $TARGET in
    arm-master)
        cd /work/freshtomato-arm/release/src-rt-6.x.4708
        ;;
    arm-ng)
        cd /work/freshtomato-arm/release/src-rt-6.x.4708
        ;;
    arm-sdk7)
        IMAGES_DIR=/work/freshtomato-arm/release/src-rt-7.x.main/src/image
        cd /work/freshtomato-arm/release/src-rt-7.x.main/src
        ;;
esac

make $@

if [ -d "$IMAGES_DIR" ]; then
    cp "$IMAGES_DIR/"* "$DEST_DIR"
fi
