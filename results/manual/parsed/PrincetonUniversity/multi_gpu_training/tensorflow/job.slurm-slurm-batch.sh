#!/bin/bash
#SBATCH --job-name=tf2-multi
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --mem=64G
#SBATCH --time=00:05:00

module purge
module load anaconda3/2021.11
conda activate tf2-gpu
python mnist_classify.py
