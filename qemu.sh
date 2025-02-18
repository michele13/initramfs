#!/bin/sh
case $1 in
  -h | --help ) 
    echo "USAGE: $(basename $0) [boot parameters]";
    exit 0;
    break;
esac

if [ ! -e data.qcow2 ]; then
  qemu-img create -f qcow2 data.qcow2 1G
  sleep 0.5
fi


echo "Press CTRL-A and X to exit the emulator"
sleep 1

append="$@"
qemu-system-x86_64 -hda data.qcow2 -nographic -kernel prebuilts/bzImage -initrd prebuilts/initrd.gz -append "panic=1 console=ttyS0 $append" -no-reboot
reset
