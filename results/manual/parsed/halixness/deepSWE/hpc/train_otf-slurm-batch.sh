#!/bin/bash
#SBATCH --job-name=SWE_otfTraining
#SBATCH --output=%x.o%j
#SBATCH --error=%x.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=12:00:00

module load miniconda3
source "$CONDA_PREFIX/etc/profile.d/conda.sh" 
conda activate swe-cv-pytorch
cd ..
python -u train_otf_grid.py -root ../datasets/arda/ -epochs 500 -image_size 768 -out_channels 3 -buffer_size 100 -buffer_memory 100
