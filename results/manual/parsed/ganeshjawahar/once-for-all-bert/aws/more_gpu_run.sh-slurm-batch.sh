#!/bin/bash
#SBATCH --job-name=moresh
#SBATCH --output=/fsx/ganayu/experiments/trial/sample-%j.out
#SBATCH --error=/fsx/ganayu/experiments/trial/sample-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=17-08:40:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_NSOCKS_PERTHREAD='4'
export NCCL_SOCKET_NTHREADS='2'
export NCC_INFO='INFO'
export SL_NUM_NODES='2'
export PYTHONPATH='$(pwd)'

export NCCL_NSOCKS_PERTHREAD=4
export NCCL_SOCKET_NTHREADS=2
export NCC_INFO=INFO
module purge
conda activate basic
export SL_NUM_NODES=2
export PYTHONPATH=$(pwd)
echo $SLURMD_NODENAME $SLURM_JOB_ID $CUDA_VISIBLE_DEVICES $SLURM_LOCALID
srun --label /fsx/ganayu/code/SuperShaper/aws/more_commands.sh
