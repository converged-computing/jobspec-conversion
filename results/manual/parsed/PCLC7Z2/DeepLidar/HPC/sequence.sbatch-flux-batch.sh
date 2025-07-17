#!/bin/bash
#FLUX: --job-name=retrain_sequence
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/'

ml git
ml gcc
ml geos
ml tensorflow
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/
cd /home/b.weinstein/DeepLidar
python retrain_sequence.py
cat analysis/pretraining_size.csv
