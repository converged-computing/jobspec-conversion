#!/bin/bash
#FLUX: --job-name=dinosaur-frito-3726
#FLUX: -t=115200
#FLUX: --urgency=16

module load cuda/11.3.1
module load cudnn/8.2.0
module load anaconda/3-5.2.0 gcc/10.2
source activate vae_att
/gpfs/data/rsingh47/ylei29/anaconda/vae_att/bin/python ./main.py
