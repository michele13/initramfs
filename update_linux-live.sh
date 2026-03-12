#!/bin/sh
touch initramfs/bin/busybox
cp -uv linux-live/config linux-live/livekitlib initramfs/lib/
cp -uv linux-live/initramfs/init initramfs/slax
cp -uiv linux-live/initramfs/static/* initramfs/bin/
cp -uiv linux-live/initramfs/shutdown initramfs/
chmod -v a+x  initramfs/slax initramfs/shutdown initramfs/bin/*
rm -v initramfs/bin/README
