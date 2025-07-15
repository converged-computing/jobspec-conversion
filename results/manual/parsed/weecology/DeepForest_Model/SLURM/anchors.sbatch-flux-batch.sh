#!/bin/bash
#FLUX: --job-name=Anchors
#FLUX: -t=259200
#FLUX: --urgency=16

export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/DeepForest/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.7/site-packages/'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/DeepForest/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.7/site-packages/
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}
cd /home/b.weinstein/DeepForest_Model/
python GenerateAnchors.py
