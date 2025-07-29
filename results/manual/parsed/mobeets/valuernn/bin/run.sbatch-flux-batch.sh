#!/bin/bash
#FLUX --job-name=quirky-lemur-3770
#FLUX --queue=shared
#FLUX -t=480
#FLUX --urgency=16

module load python/3.8.5-fasrc01
source activate pt38
srun -c 1 python quick_train.py newloss
