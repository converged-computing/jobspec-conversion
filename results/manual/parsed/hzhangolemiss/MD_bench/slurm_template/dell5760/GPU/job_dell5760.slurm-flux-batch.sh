#!/bin/bash
#FLUX: --job-name=xxx
#FLUX: -t=2592000
#FLUX: --priority=16

export CUDA_MPS_PIPE_DIRECTORY='$SLURM_SUBMIT_DIR/nvidia-mps.$SLURM_JOB_ID'
export CUDA_MPS_LOG_DIRECTORY='$SLURM_SUBMIT_DIR/nvidia-log.$SLURM_JOB_ID'

cd $SLURM_SUBMIT_DIR
export CUDA_MPS_PIPE_DIRECTORY=$SLURM_SUBMIT_DIR/nvidia-mps.$SLURM_JOB_ID
export CUDA_MPS_LOG_DIRECTORY=$SLURM_SUBMIT_DIR/nvidia-log.$SLURM_JOB_ID
nvidia-cuda-mps-control -d
sleep 1
mpiexec --bind-to core --map-by core -n 8 lmp_2Aug2023_update3_more_gcc_sfft_openmpi_cuda_mps -sf gpu -pk gpu 1 neigh yes newton on pair/only off split 1.0 -i input.lmps
sleep 1
echo quit | nvidia-cuda-mps-control
sleep 1
rm -r $SLURM_SUBMIT_DIR/nvidia-*
