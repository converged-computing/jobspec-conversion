#!/bin/bash
#SBATCH --account=def-hsajjad
#SBATCH --output=slurm.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=192000M
#SBATCH --time=10:23:00
#SBATCH --constraint=ntasks-per-node=32

export TRANSFORMERS_CACHE='/home/domenic/projects/def-hsajjad/domenic'
export HF_DATASETS_OFFLINE='1 '
export TRANSFORMERS_OFFLINE='1'

export TRANSFORMERS_CACHE=/home/domenic/projects/def-hsajjad/domenic
export HF_DATASETS_OFFLINE=1 
export TRANSFORMERS_OFFLINE=1
module load python/3.10.2 cuda nccl
module load gcc/9.3.0 arrow
sh run.sh
