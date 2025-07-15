#!/bin/bash
#FLUX: --job-name=red-egg-0779
#FLUX: --priority=16

module load cuda/10.0
module load groupmods/cudnn/10.0
source activate deepchem
python -u /srv/home/nkrakauer/moleprop/paper_comparison/pan07/optimization/opt.py > buffer.txt
