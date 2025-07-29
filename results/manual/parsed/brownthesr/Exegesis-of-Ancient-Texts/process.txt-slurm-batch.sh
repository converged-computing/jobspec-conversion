#!/bin/bash
#SBATCH --job-name=Processing Vectors
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00
#SBATCH --qos=cs

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
source activate script
python3 generation/mean_masks.py -u 
