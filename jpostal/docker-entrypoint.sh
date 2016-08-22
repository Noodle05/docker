#!/bin/sh

if [ ! -e "$LIBPOSTAL_DATA/initialed" ]; then
    /usr/bin/libpostal_data download all $LIBPOSTAL_DATA/libpostal
    touch $LIBPOSTAL_DATA/initialed
fi

exec $@
