#!/bin/bash
#FLUX: --job-name=cs1430_final_train
#FLUX: -t=172800
#FLUX: --urgency=16

module load python/3.9.0
module load cuda
source ~/Projects/cs1430/cs1430_env/bin/activate
python run.py
