#!/bin/bash
#SBATCH --job-name=job_test
#SBATCH --account=dgx2
#SBATCH --output=mpi_test_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=1

export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:128'

export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
source /raid/cs20mds14030/miniconda3/etc/profile.d/conda.sh
conda activate telugu_asr
python train.py
echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
mpirun -np 1 ./a.out >> output.txt
