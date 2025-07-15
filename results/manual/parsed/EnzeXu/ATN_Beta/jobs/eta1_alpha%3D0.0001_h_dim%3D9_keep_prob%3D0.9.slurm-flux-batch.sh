#!/bin/bash
#FLUX: --job-name="eta1_alpha=0.0001_h_dim=9_keep_prob=0.9"
#FLUX: --queue=medium
#FLUX: -t=172800
#FLUX: --priority=16

echo $(pwd) > "jobs/pwd.txt"
source /deac/csc/chenGrp/software/tensorflow/bin/activate
python run.py --num 1 --alpha 0.0001 --h_dim 9 --keep_prob 0.9 --data eta1 --k 6 --beta 1.0 --kmeans 1 --main_epoch 1000
