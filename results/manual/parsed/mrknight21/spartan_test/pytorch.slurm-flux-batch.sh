#!/bin/bash
#FLUX: --job-name=boopy-peanut-0293
#FLUX: -t=14400
#FLUX: --urgency=16

module load foss/2022a 
module load PyTorch/1.12.1
python3 quickstart_tutorial.py
sleep 60
python3 tensorqs_tutorial.py 
my-job-stats -a -n -s
