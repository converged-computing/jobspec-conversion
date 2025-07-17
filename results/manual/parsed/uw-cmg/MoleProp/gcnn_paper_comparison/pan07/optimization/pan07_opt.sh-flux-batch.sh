#!/bin/bash
#FLUX: --job-name=fugly-diablo-9452
#FLUX: --queue=sbel_cmg
#FLUX: -t=259290
#FLUX: --urgency=16

module load cuda/10.0
module load groupmods/cudnn/10.0
source activate deepchem
python /srv/home/xsun256/paper_comparison/pan07/optimization/opt.py
