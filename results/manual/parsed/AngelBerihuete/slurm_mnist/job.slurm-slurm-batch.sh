#!/bin/bash
#SBATCH --job-name=tf2-test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:01:00

module purge
module load anaconda3
conda activate tf2-gpu
srun python mnist2_classify.py
