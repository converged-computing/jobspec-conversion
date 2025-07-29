#!/bin/bash
#FLUX: --job-name=atomistic
#FLUX: -t=18000
#FLUX: --urgency=16

source /etc/profile 
module load anaconda/2020b
module load cuda/10.1
source /home/gridsan/samlg/.bashrc
conda activate chemprop
eval $CMD
