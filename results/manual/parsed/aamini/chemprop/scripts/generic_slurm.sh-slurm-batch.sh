#!/bin/bash
#SBATCH --job-name=atomistic
#SBATCH --output=logs/slurm_generic_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00

source /etc/profile 
module load anaconda/2020b
module load cuda/10.1
source /home/gridsan/samlg/.bashrc
conda activate chemprop
eval $CMD
