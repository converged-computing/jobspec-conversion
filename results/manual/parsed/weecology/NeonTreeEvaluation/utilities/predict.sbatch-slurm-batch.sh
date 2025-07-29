#!/bin/bash
#FLUX: --job-name=predict_crops
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/bin/:/home/b.weinstein/DeepTreeAttention/'
export PYTHONPATH='/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/python3.7/site-packages/:/home/b.weinstein/DeepTreeAttention/:${PYTHONPATH}'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/:${LD_LIBRARY_PATH}'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/bin/:/home/b.weinstein/DeepTreeAttention/
export PYTHONPATH=/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/python3.7/site-packages/:/home/b.weinstein/DeepTreeAttention/:${PYTHONPATH}
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/:${LD_LIBRARY_PATH}
python predict_crops.py
