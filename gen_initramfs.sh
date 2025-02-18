#!/bin/sh

cd initramfs
find . -xdev| cpio -R 0:0 -o -H newc | gzip -9 > ../prebuilts/initrd.gz
