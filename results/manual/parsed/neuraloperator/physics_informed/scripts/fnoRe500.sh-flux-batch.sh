#!/bin/bash
#FLUX: --job-name=butterscotch-nalgas-4908
#FLUX: -t=86400
#FLUX: --priority=16

python3 train_operator.py --config_path configs/operator/Re500-FNO.yaml
