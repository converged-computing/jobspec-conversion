#!/bin/bash
#FLUX: --job-name=doopy-lemon-2784
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

cd /om2/user/avbalsam/prednet
hostname
echo "Plot Data"
date "+%y/%m/%d %H:%M:%S"
source /om2/user/jangh/miniconda/etc/profile.d/conda.sh
conda activate openmind
python plot_data.py
