#!/bin/bash
#FLUX: --job-name=config_3090_6
#FLUX: -t=36000
#FLUX: --urgency=16

nvidia-smi
ifconfig | grep -o 'inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'
echo $TOKENIZERS_PARALLELISM
source /home/amangupt/anaconda3/etc/profile.d/conda.sh
conda activate mls
python3 run_benchmark.py config/config_3090_6.yaml
