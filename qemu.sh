#!/bin/sh
case $1 in
  -h | --help ) 
    echo "USAGE: $(basename $0) [boot parameters]";
    exit 0;
    break;
esac

echo "Press CTRL-A and X to exit the emulator"
sleep 1

append="$@"
qemu-system-x86_64 -nographic -kernel bzImage -initrd initrd.gz -append "panic=1 console=ttyS0 $append" -no-reboot
