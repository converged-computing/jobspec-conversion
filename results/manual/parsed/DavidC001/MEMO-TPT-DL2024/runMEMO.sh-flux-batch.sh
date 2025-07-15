#!/bin/bash
#FLUX: --job-name=grated-cupcake-0988
#FLUX: -c=4
#FLUX: --urgency=16

module load cuda/12.1
source /home/davide.cavicchini/.bashrc
conda activate SIV_hpe
python3 memo/main.py
