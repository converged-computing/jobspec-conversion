#!/bin/bash
#SBATCH --job-name=GPU-Test
#SBATCH --account=free
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=16,k20x

export CUDA_MPS_PIPE_DIRECTORY='/tmp/nvidia-mps'
export CUDA_MPS_LOG_DIRECTORY='/tmp/nvidia-log'

. /etc/profile.d/modules.sh
module purge
module load slurm
module load intel/compiler/64/15.0.0.090
module load intel/mkl/64/11.2
module load openmpi/intel/1.8.4
module load cuda/toolkit/7.5.18
if [ ! -d "/tmp/nvidia-mps" ] ; then
    mkdir "/tmp/nvidia-mps"
fi
export CUDA_MPS_PIPE_DIRECTORY="/tmp/nvidia-mps"
if [ ! -d "/tmp/nvidia-log" ] ; then
    mkdir "/tmp/nvidia-log"
fi
export CUDA_MPS_LOG_DIRECTORY="/tmp/nvidia-log"
nvidia-cuda-mps-control -d
python -u GPUTest.py
