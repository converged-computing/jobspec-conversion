#!/bin/bash
#FLUX: --job-name=frigid-taco-4861
#FLUX: -t=86400
#FLUX: --urgency=16

python3 train_operator.py --config_path configs/operator/Re500-FNO.yaml
