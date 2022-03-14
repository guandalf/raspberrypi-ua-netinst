#!/usr/bin/env bash

set -e # exit if any command fails
umask 022

[[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run script"; exit 1; }

build_dir=./build_dir
packages_dir=./packages
resources_dir=./res
scripts_dir=./scripts
device=/dev/nbd0
partition=p1

# update version and date
version_tag="$(git describe --exact-match --tags HEAD 2> /dev/null || true)"
version_commit="$(git rev-parse --short "@{0}" 2> /dev/null || true)"
if [ -n "${version_tag}" ]; then
	version_info="${version_tag} (${version_commit})"
	imgfile="raspberrypi-ua-netinst-${version_tag}.qcow2"
elif [ -n "${version_commit}" ]; then
	version_info="${version_commit}"
	imgfile="raspberrypi-ua-netinst-git-${version_commit}.qcow2"
else
	version_info="unknown"
	imgfile="raspberrypi-ua-netinst-$(date +%Y%m%d).qcow2"
fi

qemu-img create -f qcow2 ${imgfile} 1G

modprobe nbd
qemu-nbd --connect=${device} ${imgfile}
/sbin/sfdisk ${device} < part_table.txt
mkdosfs ${device}${partition}

options="rw,nosuid,nodev,uid=1000,gid=1000,shortname=mixed,dmask=0077,utf8=1,showexec,flush,uhelper=udisks2"
[ -d ./mnt ] || mkdir ./mnt
mount -t vfat -o ${options} ${device}${partition} ./mnt

cp -a ./build_dir/bootfs/* ./mnt/

umount ${device}${partition}
rmdir ./mnt
qemu-nbd --disconnect ${device}

qemu-system-aarch64 \
-M raspi3 \
-append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" \
-dtb ./build_dir/bootfs/raspberrypi-ua-netinst/bcm2710-rpi-3-b-plus.dtb \
-sd ${imgfile} \
-kernel ./build_dir/bootfs/raspberrypi-ua-netinst/kernel8.img \
-m 1G -smp 4 -serial stdio -usb -device usb-mouse -device usb-kbd \
-initrd ./build_dir/bootfs/raspberrypi-ua-netinst/initramfs.gz \
-device usb-net,netdev=net0 \
-netdev tap,ifname=tap0,id=net0