#!/bin/bash
#FLUX: --job-name=RubiksDL2
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='$PATH:~/.local/bin'

export PATH=$PATH:~/.local/bin
module load python/3.6.0
cd ~/Rubiks-Cube-DL/
pipenv run python train.py --ini ini/cube2x2-zero-goal-d30.ini -n run_${SLURM_JOBID}
