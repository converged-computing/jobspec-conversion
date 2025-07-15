#!/bin/bash
#FLUX: --job-name=moolicious-bicycle-7476
#FLUX: -t=36000
#FLUX: --priority=16

module load gcc/9.3.0 arrow python scipy-stack
python main_byt5.py train-model 
