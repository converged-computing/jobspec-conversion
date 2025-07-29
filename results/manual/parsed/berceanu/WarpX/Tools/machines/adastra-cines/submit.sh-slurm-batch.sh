#!/bin/bash
#FLUX: --job-name=warpx
#FLUX: -N=2
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'
export FI_MR_CACHE_MONITOR='memhooks  # alternative cache monitor'
export ROCFFT_RTC_CACHE_PATH='/dev/null'
export OMP_NUM_THREADS='1'
export WARPX_NMPI_PER_NODE='8'
export TOTAL_NMPI='$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))'

module purge
module load craype-accel-amd-gfx90a craype-x86-trento
module load PrgEnv-cray
module load amd-mixed
export MPICH_GPU_SUPPORT_ENABLED=1
export FI_MR_CACHE_MONITOR=memhooks  # alternative cache monitor
export ROCFFT_RTC_CACHE_PATH=/dev/null
export OMP_NUM_THREADS=1
export WARPX_NMPI_PER_NODE=8
export TOTAL_NMPI=$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))
srun -N${SLURM_JOB_NUM_NODES} -n${TOTAL_NMPI} --ntasks-per-node=${WARPX_NMPI_PER_NODE} \
    ./warpx inputs > output.txt
