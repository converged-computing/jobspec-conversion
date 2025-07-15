#!/bin/bash
#FLUX: --job-name=sticky-cupcake-7531
#FLUX: -c=7
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export FI_MR_CACHE_MONITOR='memhooks  # alternative cache monitor'
export MPICH_SMP_SINGLE_COPY_MODE='NONE'
export FI_CXI_RX_MATCH_MODE='software'
export ROCFFT_RTC_CACHE_PATH='/dev/null'
export OMP_NUM_THREADS='1'
export WARPX_NMPI_PER_NODE='8'
export TOTAL_NMPI='$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))'

export FI_MR_CACHE_MONITOR=memhooks  # alternative cache monitor
export MPICH_SMP_SINGLE_COPY_MODE=NONE
export FI_CXI_RX_MATCH_MODE=software
export ROCFFT_RTC_CACHE_PATH=/dev/null
export OMP_NUM_THREADS=1
export WARPX_NMPI_PER_NODE=8
export TOTAL_NMPI=$(( ${SLURM_JOB_NUM_NODES} * ${WARPX_NMPI_PER_NODE} ))
srun -N${SLURM_JOB_NUM_NODES} -n${TOTAL_NMPI} --ntasks-per-node=${WARPX_NMPI_PER_NODE} \
    ./warpx inputs > output.txt
