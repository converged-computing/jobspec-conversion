#!/bin/bash
#FLUX: --job-name=wobbly-animal-7149
#FLUX: --priority=16

cd /om2/user/avbalsam/prednet
hostname
echo "Plot Data"
date "+%y/%m/%d %H:%M:%S"
source /om2/user/jangh/miniconda/etc/profile.d/conda.sh
conda activate openmind
python plot_data.py
