#!/bin/bash
#FLUX: --job-name=train_w3_half
#FLUX: -c=3
#FLUX: -t=720000
#FLUX: --urgency=16

pwd; hostname; date
module purge
module load tensorflow
python ex.py 3 5 50 # data_num weight epochs 
date
