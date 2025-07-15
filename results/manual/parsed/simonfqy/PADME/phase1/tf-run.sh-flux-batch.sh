#!/bin/bash
#FLUX: --job-name=dirty-knife-7961
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=19
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python3 SimBoost/xgboost/DNN_est.py
