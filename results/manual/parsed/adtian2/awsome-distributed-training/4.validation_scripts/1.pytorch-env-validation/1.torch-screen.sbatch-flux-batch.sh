#!/bin/bash
#FLUX: --job-name=megatron_gpt
#FLUX: --exclusive
#FLUX: --urgency=16

set -ex
: "${APPS_PATH:=/apps}"
: "${IMAGE:=$APPS_PATH/pytorch-screen.sqsh}"
: "${FSX_MOUNT:=/fsx:/fsx}"
: "${SCREEN_PT_SCRIPT_PATH:=$PWD}"
declare -a ARGS=(
    --container-image $IMAGE
    --container-mount-home
    --container-mounts $FSX_MOUNT
)
echo "
Hostname: $(hostname)
"
env
/usr/bin/time srun -l "${ARGS[@]}" --mpi=pmix bash -c "
which nvidia-smi
nvidia-smi
which python
python --version
python ${SCREEN_PT_SCRIPT_PATH}/screen-pytorch.py
"
