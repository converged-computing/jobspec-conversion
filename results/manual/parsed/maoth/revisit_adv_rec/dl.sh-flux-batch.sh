#!/bin/bash
#FLUX: --job-name=red-taco-0807
#FLUX: -t=172800
#FLUX: --urgency=16

module load cudatoolkit/10.2
module load anaconda/python3.8/2020.07
source activate round10
python -u generate_attack.py \
-dataset ml-1m \
-att_type DQN \
-pop upper \
-ratio 1 \
-unroll 0 \
-tag None
