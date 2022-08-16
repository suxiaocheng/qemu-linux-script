#!/bin/bash

pushd ../linux
KERNEL=kernel8
if [ ! -f .config ]; then
	make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
fi
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- savedefconfig
cp defconfig arch/arm64/configs/bcm2711_defconfig

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs -j16

popd
