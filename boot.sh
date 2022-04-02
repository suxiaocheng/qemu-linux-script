#!/bin/bash
# qemu-system-x86_64 -m 256m -nographic   -append "nokaslr console=ttyS0 root=/dev/sda" -kernel ./source/linux-source/arch/x86_64/boot/bzImage ./qemu_rootfs.img -s -S
#qemu-system-aarch64 -M raspi3 -kernel ./source/linux-source/arch/arm/boot/zImage -sd 2022-01-28-raspios-bullseye-armhf-lite.img -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootwait" -dtb ./source/linux-source/arch/arm/boot/dts/bcm2710-rpi-3-b.dtb -nographic
qemu-system-aarch64 -M raspi3 -kernel ./kernel8.img -sd 2022-01-28-raspios-bullseye-armhf-lite.img -append "nokaslr rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootwait" -dtb bcm2710-rpi-3-b.dtb -nographic

