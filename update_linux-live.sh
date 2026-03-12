#!/bin/sh
touch initramfs/bin/busybox
cp -uv linux-live/config linux-live/livekitlib initramfs/lib/
cp -uv linux-live/initramfs/init initramfs/lib/livekit-init
cp -uiv linux-live/initramfs/static/* initramfs/bin/
cp -uiv linux-live/initramfs/shutdown initramfs/
chmod -v a+x  initramfs/lib/livekit-init initramfs/shutdown initramfs/bin/*
rm -v initramfs/bin/README
