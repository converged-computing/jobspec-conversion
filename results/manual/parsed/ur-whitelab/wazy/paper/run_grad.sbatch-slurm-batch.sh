#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=awhite
#SBATCH --constraint=A100

module load anaconda3/2020.11
module load cuda/11.2.2
module load cudnn/11.2-8.1.1
conda activate prettyB
python /scratch/zyang43/ALP-Design/paper/e2e_grad.py
