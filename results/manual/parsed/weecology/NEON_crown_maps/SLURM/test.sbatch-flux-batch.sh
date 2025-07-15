#!/bin/bash
#FLUX: --job-name=conspicuous-cattywampus-7660
#FLUX: --queue=gpu
#FLUX: --priority=16

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/crowns/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/crowns/lib/python3.7/site-packages/'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/crowns/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/crowns/lib/python3.7/site-packages/
cd /home/b.weinstein/NEON_crown_maps/
python available.py
