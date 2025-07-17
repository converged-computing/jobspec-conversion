#!/bin/bash
#FLUX: --job-name=stanky-lemon-9609
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=project
#FLUX: -t=86400
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export NCCL_SOCKET_IFNAME='^docker0,lo,bond0'
export WORK_DIR='/scratch/suptest/3d/codes/wondersync/blender_render'
export PYTHONPATH='$WORK_DIR'
export ENROOT_RESTRICT_DEV='n'
export CONTAINER_PARAMS='--no-container-mount-home \'

export NCCL_DEBUG=INFO
export NCCL_SOCKET_IFNAME="^docker0,lo,bond0"
export WORK_DIR=/scratch/suptest/3d/codes/wondersync/blender_render
export PYTHONPATH=$WORK_DIR
export ENROOT_RESTRICT_DEV=n
export CONTAINER_PARAMS="--no-container-mount-home \
 --container-remap-root --container-writable \
 --container-mounts=/scratch/vgenfmod/lipeng:/scratch/vgenfmod/lipeng \
 --container-image /scratch/suptest/3d/render_container.sqsh \
 --container-workdir=/scratch/suptest/3d/codes";
echo "Running with container params: $CONTAINER_PARAMS"
srun python test.py
source /scratch/suptest/3d/codes/container.sh && ENROOT_RESTRICT_DEV=n srun -p project --gpus-per-task=1 --ntasks-per-node=1 --nodes=1 --time=24:00:00 --cpus-per-task=16  python test.py
