#!/bin/bash
#SBATCH --output=/scratch/inf0/user/gtiwari/slurm-%A.out
#SBATCH --error=/scratch/inf0/user/gtiwari/slurm-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00

echo "canonical pose data for whole body"
cd /BS/garvita/work/code/sizer
source /BS/garvita/static00/software/miniconda3/etc/profile.d/conda.sh
conda activate pytorch3d
python trainer.py
