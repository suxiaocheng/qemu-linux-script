#!/bin/bash
qemu-system-x86_64 -m 256m -nographic   -append "nokaslr console=ttyS0 root=/dev/sda" -kernel ./source/linux-source/arch/x86_64/boot/bzImage ./qemu_rootfs.img -s -S
