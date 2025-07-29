#!/bin/bash
#SBATCH --job-name=xxx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=500M
#SBATCH --time=30-00:00:00
#SBATCH --constraint=ntasks-per-node=8,ntasks-per-socket=8

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
