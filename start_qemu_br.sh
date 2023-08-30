#!/bin/sh
(
BINARIES_DIR="${0%/*}/"
cd ${BINARIES_DIR}

DISK_SIZE=`stat sdcard.img |grep Size | awk '{print $2}'`
if [ ${DISK_SIZE} -ne "2147483648" ] ; then
	echo "[INFO] resize disk image"
	qemu-img resize sdcard.img 2g
fi

EXTRA_ARGS='-nographic'

export PATH="/work/program/aarch64/buildroot-2022.02.6/output/host/bin:${PATH}"
# qemu-system-aarch64 -M raspi3 -kernel ./source/linux-source/arch/arm64/boot/Image -sd 2022-01-28-raspios-bullseye-armhf-lite.img -append "nokaslr rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootwait" -dtb ./source/linux-source/arch/arm/boot/dts/bcm2710-rpi-3-b.dtb -nographic
exec qemu-system-aarch64 -M raspi3b -smp 4 -m 1G -kernel Image -dtb bcm2710-rpi-3-b.dtb -drive file=sdcard.img,if=sd,format=raw -append "console=ttyAMA0,115200 rootwait root=/dev/mmcblk0p2 nokasrl dyndbg=\"file irqdomain.c  +p\""  ${EXTRA_ARGS} # -s -S
)
