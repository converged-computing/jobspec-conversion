#!/bin/bash
#FLUX: --job-name=carnivorous-dog-6534
#FLUX: --priority=16

module load cuda/10.0
module load groupmods/cudnn/10.0
source activate deepchem
python /srv/home/xsun256/paper_comparison/le15/optimization/opt.py
