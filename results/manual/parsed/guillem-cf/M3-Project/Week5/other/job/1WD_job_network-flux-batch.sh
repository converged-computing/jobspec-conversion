#!/bin/bash
#FLUX: --job-name=bricky-snack-0993
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config_withoutdense/1WD_network.yaml
