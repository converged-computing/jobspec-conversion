#!/bin/bash
#FLUX: --job-name=expressive-bicycle-5732
#FLUX: --priority=16

source /usr/xtmp/vs196/mammoproj/Env/trainenv2/bin/activate
echo "start running"
nvidia-smi
python experiment.py --random_seed=1
