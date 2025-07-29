#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-task=1
#SBATCH --mem=20G

lspci -vvv |& grep "NVIDIA" |& tee slurm-lspci.out
make A100 && \
  ./main_a100
