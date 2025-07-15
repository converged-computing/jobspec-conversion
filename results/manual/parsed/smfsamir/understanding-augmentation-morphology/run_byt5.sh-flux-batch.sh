#!/bin/bash
#FLUX: --job-name=expensive-eagle-7009
#FLUX: -t=36000
#FLUX: --urgency=16

module load gcc/9.3.0 arrow python scipy-stack
python main_byt5.py train-model 
