#!/bin/bash
#FLUX --job-name=dinosaur-lemur-7717
#FLUX -t=36000
#FLUX --urgency=16

module load gcc/9.3.0 arrow python scipy-stack
python main_byt5.py train-model 
