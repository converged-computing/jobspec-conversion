#!/bin/bash
#FLUX: --job-name=mistakes_were_made
#FLUX: --queue=GPUQ
#FLUX: -t=3600
#FLUX: --urgency=16

module load PyTorch/1.7.1-fosscuda-2020b
source venv/bin/activate
python3 -m GPTime --task train --cfg_path configs/config_train.yml
