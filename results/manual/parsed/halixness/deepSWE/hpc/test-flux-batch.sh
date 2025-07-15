#!/bin/bash
#FLUX: --job-name=SWE_benchmark
#FLUX: --queue=gpu
#FLUX: -t=82800
#FLUX: --priority=16

module load miniconda3
source "$CONDA_PREFIX/etc/profile.d/conda.sh" 
conda activate swe-cv-pytorch
cd ..
python -u test.py -r ../datasets/baganza/ -npy ../datasets/arda.npy -weights runs/train_45_10_08_2021_19_28_41/model.weights -ls 2048 
