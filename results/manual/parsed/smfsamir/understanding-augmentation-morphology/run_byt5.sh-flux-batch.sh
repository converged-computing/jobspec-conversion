#!/bin/bash
#FLUX: --job-name=crunchy-rabbit-3044
#FLUX: -t=36000
#FLUX: --urgency=16

module load gcc/9.3.0 arrow python scipy-stack
python main_byt5.py train-model 
