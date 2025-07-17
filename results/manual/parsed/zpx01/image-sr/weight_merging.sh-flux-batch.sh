#!/bin/bash
#FLUX: --job-name=butterscotch-peanut-1254
#FLUX: -c=8
#FLUX: -t=259200
#FLUX: --urgency=15

export PYTHONUNBUFFERED='1'

pwd
hostname
date
nvidia-smi
echo "Starting SwinIR Weight Merging job (classical SR)..."
source ~/.bashrc
conda activate image-sr
export PYTHONUNBUFFERED=1
for ALPHA in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9
do
        python3 weight_merging.py \
        --alpha ${ALPHA}
done
date
