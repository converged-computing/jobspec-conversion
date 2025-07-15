#!/bin/bash
#FLUX: --job-name=eccentric-puppy-8035
#FLUX: -c=4
#FLUX: --priority=16

module load cuda/12.1
source /home/davide.cavicchini/.bashrc
conda activate SIV_hpe
python3 memo/main.py
