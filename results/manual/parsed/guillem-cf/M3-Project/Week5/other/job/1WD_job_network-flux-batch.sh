#!/bin/bash
#FLUX: --job-name=adorable-peanut-butter-0005
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config_withoutdense/1WD_network.yaml
