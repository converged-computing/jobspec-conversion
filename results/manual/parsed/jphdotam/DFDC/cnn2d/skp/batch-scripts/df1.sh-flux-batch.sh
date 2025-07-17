#!/bin/bash
#FLUX: --job-name=arid-onion-7770
#FLUX: --queue=gpu
#FLUX: -t=518400
#FLUX: --urgency=16

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python run.py configs/experiments/experiment045.yaml train --gpu 0 --num-workers 4 
