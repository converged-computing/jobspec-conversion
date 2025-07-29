#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=A100

module load anaconda3/2020.11
module load cuda/11.0
conda activate prettyB
python /scratch/zyang43/ALP-Design/paper/random_search.py
