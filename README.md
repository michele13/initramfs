# My Custom Initramfs

**Linux Kernel:** 6.12.1
**Busybox:** 1.36.1

## 1. Goals

* Statically compiled busybox
* Simple directory structure and init scripts
* Easily rebuild the initramfs after booting the system
* Easily customisable with its autorun script

## 2.  Minimal Directory structure

```
/live
/tmp (chmod 1777)
/dev
/sys
/proc
/bin/busybox
/bin/rebuild-initramfs
/bin/sh -> busybox
/bin/init -> /init
/bin/applets/(busybox applets)
```

**optional lib dirs you might want to create**

```
/usr -> / (optional usr)
/lib
/lib64 -> /lib
```

**other directories could be a symlink from other directories**

```
/etc -> /data/etc
/home -> /data/home
```

## 3. Startup

### 3.1 First stage init (/init)

The main init executable is `/init`. It is a script run form the system shell and 
it's the firt process of the system (PID 1). Its job is to mount `/proc`, `/sys` and `/dev` and
check if the kernel command line has the `rescue` argument: if it does it drops you to a shell
(RESCUE MODE), else it reads `/rc.init` where the rest of the magic happens.

### 3.2 Second stage init (/rc.init)

`/rc.init` is a text file that is sourced from `/init`. We still are PID 1.

From the [kernel documentation](https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html): 
> The kernel parses parameters from the kernel command line up to “–”; if it doesn’t recognize a parameter and it doesn’t contain a ‘.’, the parameter gets passed to init: parameters with > ‘=’ go into init’s environment, others are passed as command line arguments to init. Everything after “–” is passed as an argument to init.

1. If we pass the parameter `live=/dev/sda1`, `live=LABEL=(disk-label)` or `live=UUID=(part UUID)` to the kernel command line, the specified partitio  will be
mounted under /live.

2. If the script `/live/$distro/boot/autostart.sh` exists, it will be read and executed.
   - if the  `$distro` environment variable is not passed using the kernel commandline, `init.rc` will look for `/live/boot/autostart.sh`

3. It runs a root shell


## Interesting Projects

* [Oasis Linux](https://github.com/oasislinux/oasis/tree/master)
* [Vanilla Linux](https://projects.malikania.fr/vanilla/index.html)
* [Solyste](https://framagit.org/Ypnose/solyste/)
* [Bootstrap Linux](https://github.com/pikhq/bootstrap-linux/)
* [Minimal Linux Script](https://github.com/ivandavidov/minimal-linux-script)
* [Minimal Linux Live](https://github.com/ivandavidov/minimal)
* [Yosild](https://github.com/jaromaz/yosild/)
* [Iglunix](https://github.com/iglunix/iglunix/)
* [Sta.li](https://sta.li/)
* [Static Linux](http://flibex.ru/)

## Other interesting readings

* [Custom Initamfs - Gentoo Wiki](https://wiki.gentoo.org/wiki/Custom_Initramfs)
* [Linux Kernel Boot Parameters - Linux Kernel Docs](https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html)
* [ramfs, rootfs and initramfs - Linux Kernel Docs](https://github.com/torvalds/linux/blob/master/Documentation/filesystems/ramfs-rootfs-initramfs.rst)
* [Using the initial RAM disk (initrd) - Linux Kernel Docs](https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/initrd.rst)
