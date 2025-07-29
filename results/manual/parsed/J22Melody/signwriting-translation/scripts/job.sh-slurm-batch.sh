#!/bin/bash
#SBATCH --job-name=baseline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:Tesla-V100-32GB:1
#SBATCH --mem=4000M
#SBATCH --time=3-00:00:00

module load nvidia/cuda11.2-cudnn8.1.0
module load anaconda3
source activate joey
cd tools/joeynmt
pip install -e .
cd ..
cd ..
stdbuf -o0 -e0 srun --unbuffered $1 $2
