#!/bin/bash
#SBATCH --job-name=vit-era5
#SBATCH --account=ntrain4
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=01:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=4

export FI_MR_CACHE_MONITOR='userfaultfd'
export HDF5_USE_FILE_LOCKING='FALSE'
export MASTER_ADDR='$(hostname)'
export CUDA_VISIBLE_DEVICES='3,2,1,0'

singularity
exec
nersc/pytorch:ngc-23.07-v0
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
