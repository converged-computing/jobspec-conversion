#!/bin/bash
#FLUX: --job-name=conspicuous-butter-7042
#FLUX: --queue=shared
#FLUX: -t=480
#FLUX: --urgency=16

module load python/3.8.5-fasrc01
source activate pt38
srun -c 1 python quick_train.py newloss
