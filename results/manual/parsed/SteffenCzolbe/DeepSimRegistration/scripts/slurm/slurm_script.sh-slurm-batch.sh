#!/bin/bash
#SBATCH --job-name=unnamed job
#SBATCH --output=slurm_logs/slurm-%j.%x.out
#SBATCH --error=slurm_logs/slurm-%j.%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:titanrtx:1
#SBATCH --mem=30000M
#SBATCH --time=5-00:00:00

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
echo Host: 
hostname
echo
echo CUDA_VISIBLE_DEVICES:
echo $CUDA_VISIBLE_DEVICES
echo
echo running command:
echo $@
echo
$@
