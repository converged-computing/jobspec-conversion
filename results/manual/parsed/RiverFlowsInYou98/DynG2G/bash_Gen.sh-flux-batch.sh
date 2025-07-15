#!/bin/bash
#FLUX: --job-name=anxious-hippo-7266
#FLUX: --priority=16

module load python/3.9.0
module load cuda/11.3.1
module load cudnn/8.2.0
source ~/envs/DynG2G/bin/activate
python3 -u Gen.py -f configs/config-1.yaml
