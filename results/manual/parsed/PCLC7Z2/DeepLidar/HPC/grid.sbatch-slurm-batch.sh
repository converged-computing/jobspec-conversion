#!/bin/bash
#FLUX: --job-name=Grid
#FLUX: -c=2
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
echo $PYTHONPATH
cd /home/b.weinstein/DeepLidar
which python
python site_grid.py
cat analysis/site_grid.csv
