#!/bin/bash
#SBATCH --job-name=Unit Testing
#SBATCH --mail-user=manal.hamdi@tum.de
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load python/anaconda3
conda activate raft
python3 core/Tests.py
