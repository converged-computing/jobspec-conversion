#!/bin/bash
#SBATCH --job-name=pl-run
#SBATCH --output=slurm_logs/pl-run-%j.log
#SBATCH --mail-user=kl5675@princeton.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun \
  python3 run_ec.py fit\
  --model ../configs/ef/model.yml \
  --trainer ../configs/ef/train.yml \
  --data ../configs/ef/data.yml \
  $@
