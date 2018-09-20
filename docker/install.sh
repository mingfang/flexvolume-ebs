#!/bin/sh

set -o errexit
set -o pipefail

VENDOR=flexvolume
DRIVER=ebs

# Assuming the single driver file is located at /$DRIVER inside the DaemonSet image.

driver_dir=$VENDOR${VENDOR:+"~"}${DRIVER}
if [ ! -d "/volumeplugins/$driver_dir" ]; then
  mkdir "/volumeplugins/$driver_dir"
fi

cp "/$DRIVER" "/volumeplugins/$driver_dir/.$DRIVER"
mv -f "/volumeplugins/$driver_dir/.$DRIVER" "/volumeplugins/$driver_dir/$DRIVER"

while : ; do
  sleep 3600
done