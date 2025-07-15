#!/bin/bash
#FLUX: --job-name=warpx
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --priority=16

export MPICH_GPU_SUPPORT_ENABLED='1'
export FI_MR_CACHE_MONITOR='memhooks  # alternative cache monitor'
export ROCFFT_RTC_CACHE_PATH='/dev/null'
export OMP_NUM_THREADS='1'
export WARPX_NMPI_PER_NODE='8'
export TOTAL_NMPI='$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))'

module purge
module load cpe/23.12
module load craype-accel-amd-gfx90a craype-x86-trento
module load PrgEnv-cray
module load CCE-GPU-3.0.0
module load amd-mixed/5.2.3
date
module list
export MPICH_GPU_SUPPORT_ENABLED=1
export FI_MR_CACHE_MONITOR=memhooks  # alternative cache monitor
export ROCFFT_RTC_CACHE_PATH=/dev/null
export OMP_NUM_THREADS=1
export WARPX_NMPI_PER_NODE=8
export TOTAL_NMPI=$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))
srun -N${SLURM_JOB_NUM_NODES} -n${TOTAL_NMPI} --ntasks-per-node=${WARPX_NMPI_PER_NODE} \
     --cpus-per-task=8 --threads-per-core=1 --gpu-bind=closest \
    ./warpx inputs > output.txt
