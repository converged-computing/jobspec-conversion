#!/bin/bash
#FLUX: --job-name=moolicious-chip-4976
#FLUX: --exclusive
#FLUX: --queue=a3mega
#FLUX: --urgency=16

: "${NEMOFW_VERSION:=23.11}"
srun docker build --build-arg="NEMOFW_VERSION=${NEMOFW_VERSION}" -t nemofw:tcpxo-"${NEMOFW_VERSION}" .
srun rm -f nemofw+tcpxo-"${NEMOFW_VERSION}".sqsh
srun enroot import dockerd://nemofw:tcpxo-"${NEMOFW_VERSION}"
srun \
	--container-mounts="${PWD}":/workspace/mount_dir,/var/tmp:/var/tmp \
	--container-image=./nemofw+tcpxo-"${NEMOFW_VERSION}".sqsh \
	bash -c "cp -r /opt/NeMo-Megatron-Launcher/requirements.txt /opt/NeMo-Megatron-Launcher/launcher_scripts /opt/NeMo-Megatron-Launcher/auto_configurator /workspace/mount_dir/"
