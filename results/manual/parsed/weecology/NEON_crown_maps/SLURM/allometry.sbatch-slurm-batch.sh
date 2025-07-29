#!/bin/bash
#FLUX: --job-name=allometry
#FLUX: -t=259200
#FLUX: --urgency=16

export SLURM_TMPDIR='/orange/idtrees-collab/tmp/'
export TMPDIR='/orange/idtrees-collab/tmp/'
export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/crowns/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/crowns/lib/python3.7/site-packages/'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}'

export SLURM_TMPDIR=/orange/idtrees-collab/tmp/
export TMPDIR=/orange/idtrees-collab/tmp/
module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/crowns/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/crowns/lib/python3.7/site-packages/
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}
cd /home/b.weinstein/NEON_crown_maps/
python allometry.py
