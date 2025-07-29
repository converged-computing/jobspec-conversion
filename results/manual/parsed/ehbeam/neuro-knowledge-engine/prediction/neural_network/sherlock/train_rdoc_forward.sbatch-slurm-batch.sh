#!/bin/bash
#SBATCH --job-name=tr_rdo_forward
#SBATCH --output=logs/tr_rdoc_forward.%j.out
#SBATCH --error=logs/tr_rdoc_forward.%j.err
#SBATCH --mail-user=ebeam@stanford.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=aetkin

module load python/3.6 py-pytorch/1.0.0_py36 viz py-matplotlib/3.1.1_py36
srun python3 train_rdoc_forward.py
