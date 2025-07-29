#!/bin/bash
#SBATCH --job-name=SWE_benchmark
#SBATCH --output=%x.o%j
#SBATCH --error=%x.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=23:00:00

module load miniconda3
source "$CONDA_PREFIX/etc/profile.d/conda.sh" 
conda activate swe-cv-pytorch
cd ..
python -u test.py -r ../datasets/baganza/ -npy ../datasets/arda.npy -weights runs/train_45_10_08_2021_19_28_41/model.weights -ls 2048 
