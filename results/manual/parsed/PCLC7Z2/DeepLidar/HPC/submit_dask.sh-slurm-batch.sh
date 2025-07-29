#!/bin/bash
#FLUX: --job-name=Dask_Generation
#FLUX: -t=172800
#FLUX: --urgency=16

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/'

ml gcc
ml git
ml geos
ml tensorflow
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/
sleep 2
python /home/b.weinstein/DeepLidar/dask_generate.py
