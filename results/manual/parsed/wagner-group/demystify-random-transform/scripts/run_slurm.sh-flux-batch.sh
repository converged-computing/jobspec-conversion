#!/bin/bash
#FLUX: --job-name=rand-smooth
#FLUX: -n=2
#FLUX: -c=2
#FLUX: --queue=savio3_gpu
#FLUX: -t=86400
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate base
python test.py configs/test_img_rand_fixed.yml
