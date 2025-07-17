#!/bin/bash
#FLUX: --job-name=yolact
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module load python/3.7.1
module load cuda/10.0
module load cudnn/7.4.2
source ~/ib/bin/activate
python train.py --config=yolact_base_config
