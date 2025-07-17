#!/bin/bash
#FLUX: --job-name=bricky-pastry-2326
#FLUX: --queue=yoda
#FLUX: -t=10800
#FLUX: --urgency=16

source /home/${USER}/miniconda3/etc/profile.d/conda.sh
conda activate listen2yourheart
python3 listen2yourheart/src/training/pretrain.py $@
