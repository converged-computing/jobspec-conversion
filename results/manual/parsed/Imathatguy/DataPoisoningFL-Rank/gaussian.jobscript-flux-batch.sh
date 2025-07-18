#!/bin/bash
#FLUX: --job-name=butterscotch-eagle-5805
#FLUX: -t=7200
#FLUX: --urgency=16

module load python/3.9.4
module load pytorch/1.8.1-py39-cuda112
module load torchvision/0.9.1-py39
sleep 5s
python gaussian_attack.py --dataset $D --p_workers $P --def_method $M --rep_n $R
