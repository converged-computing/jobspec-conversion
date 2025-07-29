#!/bin/bash
#SBATCH --job-name=mnist
#SBATCH --account=pls0144
#SBATCH --output=alazar-%j.out
#SBATCH --mail-user=alazar@ysu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=05:00:00

module load miniconda3
module load cuda/11.8.0
source activate torch
srun --gpu_cmode=exclusive NCCL_P2P_LEVEL=NVL python 3_mnist_pl.py
