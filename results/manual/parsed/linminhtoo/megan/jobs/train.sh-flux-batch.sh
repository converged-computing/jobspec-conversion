#!/bin/bash
#FLUX: --job-name=boopy-buttface-9472
#FLUX: -c=8
#FLUX: -t=108000
#FLUX: --urgency=16

source /cm/shared/engaging/anaconda/2018.12/etc/profile.d/conda.sh
source env_seed77777777.sh
module load gcc/8.3.0
python3 bin/train.py uspto_50k models/uspto_50k
