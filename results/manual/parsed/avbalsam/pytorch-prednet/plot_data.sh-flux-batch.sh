#!/bin/bash
#FLUX: --job-name=dinosaur-bike-3699
#FLUX: --urgency=16

cd /om2/user/avbalsam/prednet
hostname
echo "Plot Data"
date "+%y/%m/%d %H:%M:%S"
source /om2/user/jangh/miniconda/etc/profile.d/conda.sh
conda activate openmind
python plot_data.py
