#!/bin/bash
#FLUX: --job-name=strawberry-cat-2218
#FLUX: --queue=compsci-gpu
#FLUX: -t=864000
#FLUX: --urgency=16

source /usr/xtmp/vs196/mammoproj/Env/trainenv2/bin/activate
echo "start running"
nvidia-smi
python experiment.py --random_seed=1
