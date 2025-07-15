#!/bin/bash
#FLUX: --job-name=goodbye-buttface-5898
#FLUX: --priority=16

module load Python/3.6.4-foss-2017a
module load CUDA/9.0.176
source /homedtic/mwon/envs/amd/bin/activate
python -u main.py --architecture 'pons_won' \
  --conv_channels 16 \
  --batch_size 16 \
  --dataset 'msd' --data_type 'spec' \
  --data_path '/homedtic/mwon/dataset/msd' --model_save_path './../models/msd'
