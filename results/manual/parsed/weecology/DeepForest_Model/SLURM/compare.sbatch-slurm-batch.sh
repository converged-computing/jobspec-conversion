#!/bin/bash
#FLUX: --job-name=DeepForest
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/DeepForest/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.7/site-packages/'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/DeepForest/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.7/site-packages/
cd /home/b.weinstein/DeepForest_Model/Weinstein_unpublished/
python compare.py
