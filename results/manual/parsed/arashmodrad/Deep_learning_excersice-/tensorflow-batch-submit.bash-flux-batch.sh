#!/bin/bash
#FLUX: --job-name=expensive-latke-8416
#FLUX: -c=28
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 1000
module load cuda10.0/toolkit/10.0.130 # loading cuda libraries/drivers 
module load python/intel/3.7          # loading python environment
python3 train_cnn_script.py
