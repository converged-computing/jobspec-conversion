#!/bin/bash
#FLUX: --job-name=vit-era5
#FLUX: -c=32
#FLUX: --queue=regular
#FLUX: -t=3600
#FLUX: --urgency=16

export FI_MR_CACHE_MONITOR='userfaultfd'
export HDF5_USE_FILE_LOCKING='FALSE'
export MASTER_ADDR='$(hostname)'
export CUDA_VISIBLE_DEVICES='3,2,1,0'

DATADIR=/pscratch/sd/s/shas1693/data/sc23_tutorial_data/downsampled
LOGDIR=${SCRATCH}/sc23-dl-tutorial/logs
mkdir -p ${LOGDIR}
args="${@}"
export FI_MR_CACHE_MONITOR=userfaultfd
export HDF5_USE_FILE_LOCKING=FALSE
if [ "${ENABLE_PROFILING:-0}" -eq 1 ]; then
    echo "Enabling profiling..."
    NSYS_ARGS="--trace=cuda,cublas,nvtx --kill none -c cudaProfilerApi -f true"
    NSYS_OUTPUT=${LOGDIR}/${PROFILE_OUTPUT:-"profile"}
    export PROFILE_CMD="nsys profile $NSYS_ARGS -o $NSYS_OUTPUT"
fi
export MASTER_ADDR=$(hostname)
export CUDA_VISIBLE_DEVICES=3,2,1,0
set -x
srun -u shifter -V ${DATADIR}:/data -V ${LOGDIR}:/logs \
    bash -c "
    source export_DDP_vars.sh
    ${PROFILE_CMD} python train.py ${args}
    "
