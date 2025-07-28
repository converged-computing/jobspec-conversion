#!/bin/bash
#FLUX: --job-name=expensive-sundae-5616
#FLUX: -c=8
#FLUX: --queue=GPU
#FLUX: --urgency=16

set -x
set -u
set -e
source ~/anaconda3/etc/profile.d/conda.sh
conda activate tf1
python3 -m planet.scripts.dual2 --logdir benchmark --params "{train_steps: 0, max_steps: 1e7, train_action_noise: 0.0, planner: dual2}" --num_runs 1 --resume_runs True
