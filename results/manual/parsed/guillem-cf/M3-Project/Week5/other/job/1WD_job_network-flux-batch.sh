#!/bin/bash
#FLUX: --job-name=rainbow-lamp-7023
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config_withoutdense/1WD_network.yaml
