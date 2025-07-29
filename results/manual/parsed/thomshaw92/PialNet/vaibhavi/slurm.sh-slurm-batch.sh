#!/bin/bash
#SBATCH --job-name=PialNet
#SBATCH --output=out_wiener.txt
#SBATCH --error=error_wiener.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:tesla-smx2:1
#SBATCH --mem=50000

module load cuda/10.0.130
module load gnu7
module load openmpi3
module load anaconda/3.6
source activate /opt/ohpc/pub/apps/tensorflow_2.0.0
srun -n 1 python3 vaibhavi/main.py
