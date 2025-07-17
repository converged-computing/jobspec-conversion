#!/bin/bash
#FLUX: --job-name=scPDB -s coach420_mlig -ag multi
#FLUX: --queue=GPU-shared
#FLUX: -t=28800
#FLUX: --urgency=16

module load anaconda3
conda activate # source /opt/packages/anaconda3/etc/profile.d/conda.sh
module load cuda/11.7.1
conda activate pytorch_env
python3 train.py -s coach420_mlig -ag multi
