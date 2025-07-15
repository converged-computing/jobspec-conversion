#!/bin/bash
#FLUX: --job-name=SWE_otfTraining
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

module load miniconda3
source "$CONDA_PREFIX/etc/profile.d/conda.sh" 
conda activate swe-cv-pytorch
cd ..
python -u train_otf_grid.py -root ../datasets/arda/ -epochs 500 -image_size 768 -out_channels 3 -buffer_size 100 -buffer_memory 100
