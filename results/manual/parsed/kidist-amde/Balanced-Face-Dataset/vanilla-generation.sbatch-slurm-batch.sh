#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

source /home/${USER}/.bashrc;
source activate tf1.15-env; 
nvidia-smi; 
python stylegan_generation/race_labeled_stylegan_face_generator.py  -e  ~/dataset/UTK-FACE-preprocessed-models -o  ~/dataset/stylegan-generated-vanilla -n 100000
