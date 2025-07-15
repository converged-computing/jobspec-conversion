#!/bin/bash
#FLUX: --job-name=peachy-nalgas-2299
#FLUX: -t=86400
#FLUX: --urgency=16

python3 train_operator.py --config_path configs/operator/Re500-FNO.yaml
