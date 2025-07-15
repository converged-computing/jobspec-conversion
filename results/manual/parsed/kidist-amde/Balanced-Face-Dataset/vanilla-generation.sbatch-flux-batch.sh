#!/bin/bash
#FLUX: --job-name=bumfuzzled-snack-6717
#FLUX: --priority=16

source /home/${USER}/.bashrc;
source activate tf1.15-env; 
nvidia-smi; 
python stylegan_generation/race_labeled_stylegan_face_generator.py  -e  ~/dataset/UTK-FACE-preprocessed-models -o  ~/dataset/stylegan-generated-vanilla -n 100000
