#!/bin/bash
#FLUX: --job-name=tart-peanut-butter-7349
#FLUX: --priority=16

source /work/09320/lpersyn/ls6/anaconda3/etc/profile.d/conda.sh
conda activate ../cs394-work-env
python ./tianshou/atari_sac.py --logdir $SCRATCH/cs394R/final_project_logs/   # Do not use ibrun or any other MPI launcher
