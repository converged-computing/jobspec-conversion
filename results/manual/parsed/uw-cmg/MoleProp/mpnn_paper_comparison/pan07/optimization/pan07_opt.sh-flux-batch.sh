#!/bin/bash
#FLUX: --job-name=placid-lettuce-0533
#FLUX: --queue=sbel_cmg
#FLUX: -t=864090
#FLUX: --urgency=16

module load cuda/10.0
module load groupmods/cudnn/10.0
source activate deepchem
python -u /srv/home/nkrakauer/moleprop/paper_comparison/pan07/optimization/opt.py > buffer.txt
