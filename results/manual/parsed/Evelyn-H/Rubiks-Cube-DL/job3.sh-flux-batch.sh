#!/bin/bash
#FLUX: --job-name=RubiksDL3
#FLUX: -t=172800
#FLUX: --urgency=16

export PATH='$PATH:~/.local/bin'

export PATH=$PATH:~/.local/bin
module load python/3.6.0
cd ~/Rubiks-Cube-DL/
pipenv run python train.py --ini ini/cube3x3-zero-goal-decay-d50.ini -n run_${SLURM_JOBID}
