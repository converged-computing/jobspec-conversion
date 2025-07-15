#!/bin/bash
#FLUX: --job-name=fugly-bits-3415
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=19
#FLUX: --priority=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python3 SimBoost/xgboost/DNN_est.py
