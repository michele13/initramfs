#!/bin/sh

if [ -n "$(which grub-mkstandalone)" ]; then
  # https://wiki.archlinux.org/title/GRUB/Tips_and_tricks#GRUB_standalone
  rm tmp.cfg
  echo 'configfile ${cmdpath}/grub.cfg' > tmp.cfg
  grub-mkstandalone -d /usr/lib/grub/x86_64-efi/ -O x86_64-efi --modules="part_gpt part_msdos" --locales="" --themes="" -o "prebuilts/grubx64_standalone.efi" "boot/grub/grub.cfg=tmp.cfg" -v || exit 1
  rm tmp.cfg
  echo "FINISH"
  exit 0
else
  echo "grub-mkstandalone not found in your PATH! Did you install grub?"
  exit 404
fi
