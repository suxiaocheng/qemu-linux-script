#!/bin/bash

NUM_CPU=`cat /proc/cpuinfo |grep processor | wc -l`
NUM_CPU=$((NUM_CPU*2))

pushd ../linux
KERNEL=kernel8
if [ ! -f .config ]; then
	make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
fi
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- savedefconfig
cp defconfig arch/arm64/configs/bcm2711_defconfig

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs -j${NUM_CPU}

popd
