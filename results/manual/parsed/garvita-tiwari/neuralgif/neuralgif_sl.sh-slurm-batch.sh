#!/bin/bash
#SBATCH --output=/scratch/inf0/user/gtiwari/slurm-%A.out
#SBATCH --error=/scratch/inf0/user/gtiwari/slurm-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --partition=gpu20

echo "neuralGIF pytorch implementation"
cd /BS/garvita/work/code/neuralgif
source /BS/garvita/static00/software/miniconda3/etc/profile.d/conda.sh
conda activate if-net_10
python trainer.py
