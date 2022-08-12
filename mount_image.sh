#!/bin/bash

IMAGE_NAME="2022-04-04-raspios-bullseye-armhf-lite.img"
IMAGE_MOUNT_DIR="image"
IMAGE_MOUNT_PREFIX="disk"

if [ $# -ge 1 ]; then
	MOUNT_PART=$1
fi

if [ -z "${MOUNT_PART}" ]; then
	MOUNT_PART=1
fi

if [ -f ${IMAGE_NAME} ]; then
	IMAGE_COUNT=`fdisk -l ${IMAGE_NAME} | egrep "${IMAGE_NAME}[0-9]" |wc -l`
	echo "[INFO] ${IMAGE_NAME} contain ${IMAGE_COUNT} image"

	if [ ${MOUNT_PART} -gt ${IMAGE_COUNT} ]; then
		echo "[ERROR] can't mount ${MOUNT_PART} in image ${IMAGE_NAME}"
		exit 0
	fi

	if [ ! -d ${IMAGE_MOUNT_DIR} ]; then
		mkdir ${IMAGE_MOUNT_DIR}
	fi

	if [ ! -d ${IMAGE_MOUNT_DIR}"/"${IMAGE_MOUNT_PREFIX}${MOUNT_PART} ]; then
		mkdir ${IMAGE_MOUNT_DIR}"/"${IMAGE_MOUNT_PREFIX}${MOUNT_PART}
	fi
	IMAGE2_OFFSET_SEC=`fdisk -l ${IMAGE_NAME} | grep ${IMAGE_NAME}$MOUNT_PART |awk '{print $2}'`
	IMAGE2_OFFSET_BYTE=$((IMAGE2_OFFSET_SEC*512))

	echo "[INFO] image offset sector: ${IMAGE2_OFFSET_SEC}, byte ${IMAGE2_OFFSET_BYTE}"

	if [ -n ${IMAGE2_OFFSET_SEC} ]; then
		echo "[INFO] Going to mount ${IMAGE_NAME} at offset ${IMAGE2_OFFSET_BYTE} to dir ${IMAGE_MOUNT_DIR}"/"${IMAGE_MOUNT_PREFIX}${MOUNT_PART}"
		sudo mount -o loop,offset=${IMAGE2_OFFSET_BYTE} ${IMAGE_NAME} ${IMAGE_MOUNT_DIR}"/"${IMAGE_MOUNT_PREFIX}${MOUNT_PART}

		if [ $? -ne 0 ]; then
			echo "[ERROR] ${IMAGE_NAME}$MOUNT_PART mount fail"
		else
			echo "[INFO] ${IMAGE_NAME}$MOUNT_PART mount suecessfully"
		fi
	else
		echo "[ERROR] ${IMAGE_NAME}$MOUNT_PART didn't have offset"
	fi
fi
