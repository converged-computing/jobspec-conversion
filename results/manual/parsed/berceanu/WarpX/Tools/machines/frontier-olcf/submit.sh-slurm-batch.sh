#!/bin/bash
#SBATCH --job-name=warpx
#SBATCH --account=<project
#SBATCH --output=%x-%j.out
#SBATCH --nodes=20
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --gpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=batch
#SBATCH --constraint=ntasks-per-node=8

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
