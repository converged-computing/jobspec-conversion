#!/bin/bash
#FLUX: --job-name=gen_linear
#FLUX: -c=2
#FLUX: -t=18000
#FLUX: --priority=16

module load python3/intel/3.7.3
python3 train_mod.py --nepochs_path 2000  --model_dir model_data
