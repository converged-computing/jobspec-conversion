#!/bin/bash
#FLUX: --job-name=train_rainbow
#FLUX: --queue=gpu-a100
#FLUX: -t=18000
#FLUX: --urgency=16

source /work/09320/lpersyn/ls6/anaconda3/etc/profile.d/conda.sh
conda activate ../cs394-work-env
python ./tianshou/atari_rainbow.py --logdir $SCRATCH/cs394R/final_project_logs/     # Do not use ibrun or any other MPI launcher
