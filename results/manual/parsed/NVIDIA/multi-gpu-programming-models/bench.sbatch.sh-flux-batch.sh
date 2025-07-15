#!/bin/bash
#FLUX: --job-name=swampy-snack-8066
#FLUX: --urgency=16

export SRUN_ARGS='--cpu-bind=none --mpi=none --no-container-remap-root --container-mounts=$CONTAINER_MNTS --container-workdir=/mnt --container-name=$CONTAINER_NAME'
export OMPI_MCA_coll_hcoll_enable='0'
export MPIRUN_ARGS='--oversubscribe'

: "${ENROOT_IMG_PATH:=.}"
: "${LUSTRE:=.}"
IMG=nvcr.io/nvidia/nvhpc:24.1-devel-cuda12.3-ubuntu22.04
SQUASHFS_IMG=$ENROOT_IMG_PATH/`echo "$IMG" | md5sum | cut -f1 -d " "`
CONTAINER_NAME=HPCSDK-CONTAINER
CONTAINER_MNTS=$LUSTRE/workspace/multi-gpu-programming-models:/mnt
start=`date`
if [[ -f "$SQUASHFS_IMG" ]]; then
    echo "Using: $SQUASHFS_IMG"
else
    echo "Fetching $IMG to $SQUASHFS_IMG"
    srun -n 1 -N 1 --ntasks-per-node=1 enroot import -o $SQUASHFS_IMG docker://$IMG
    echo "$IMG" > "${SQUASHFS_IMG}.url"
fi
CONTAINER_IMG=$SQUASHFS_IMG
if [[ ! -f "$CONTAINER_IMG" ]]; then
    echo "Falling back to $IMG"
    CONTAINER_IMG=$IMG
fi
srun -N ${SLURM_JOB_NUM_NODES} \
     -n ${SLURM_JOB_NUM_NODES} \
     --ntasks-per-node=1 \
     --container-image=$CONTAINER_IMG \
     --container-name=$CONTAINER_NAME \
     true
export SRUN_ARGS="--cpu-bind=none --mpi=none --no-container-remap-root --container-mounts=$CONTAINER_MNTS --container-workdir=/mnt --container-name=$CONTAINER_NAME"
export OMPI_MCA_coll_hcoll_enable=0
export MPIRUN_ARGS="--oversubscribe"
srun $SRUN_ARGS -n 1 /bin/bash -c "./test.sh clean; sleep 1; ./test.sh"
srun -n 1 /bin/bash -c "sudo nvidia-smi -lgc 1980,1980"
srun $SRUN_ARGS -n 1 ./bench.sh
srun $SRUN_ARGS -n 1 /bin/bash -c "nvidia-smi; modinfo gdrdrv; env; nvcc --version; mpicxx --version"
