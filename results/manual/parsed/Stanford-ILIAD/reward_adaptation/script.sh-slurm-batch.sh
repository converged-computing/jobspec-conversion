#!/bin/bash
#FLUX: --job-name=spbr7
#FLUX: -c=4
#FLUX: --queue=iliad
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0 python train.py --env nav1_sparse --bs 7 --experiment_dir output/sparse --expt_type ours
echo "done"
