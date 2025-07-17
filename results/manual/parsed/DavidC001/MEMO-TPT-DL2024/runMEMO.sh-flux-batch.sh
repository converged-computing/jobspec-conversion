#!/bin/bash
#FLUX: --job-name=anxious-onion-6854
#FLUX: -c=4
#FLUX: --queue=edu-20h
#FLUX: -t=1200
#FLUX: --urgency=16

module load cuda/12.1
source /home/davide.cavicchini/.bashrc
conda activate SIV_hpe
python3 memo/main.py
