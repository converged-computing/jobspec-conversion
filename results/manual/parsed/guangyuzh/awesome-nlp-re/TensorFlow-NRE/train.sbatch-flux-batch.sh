#!/bin/bash
#FLUX: --job-name=NRE_train
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load python3/intel/3.5.3
module load tensorflow/python3.5/1.0.1 cuda/8.0.44
python3 -u train_GRU.py > logs/NRE_train.log
