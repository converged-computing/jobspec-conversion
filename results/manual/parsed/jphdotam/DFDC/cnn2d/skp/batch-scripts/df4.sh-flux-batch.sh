#!/bin/bash
#FLUX: --job-name=eccentric-knife-2418
#FLUX: --queue=gpu
#FLUX: --urgency=16

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python run.py configs/experiments/experiment026.yaml train --gpu 0,1,2,3 --num-workers 4 
