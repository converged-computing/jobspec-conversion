#!/bin/bash
#FLUX: --job-name=grated-staircase-6723
#FLUX: --queue=gpu
#FLUX: -t=518400
#FLUX: --urgency=16

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python run.py configs/experiments/experiment026.yaml train --gpu 0,1,2,3 --num-workers 4 
