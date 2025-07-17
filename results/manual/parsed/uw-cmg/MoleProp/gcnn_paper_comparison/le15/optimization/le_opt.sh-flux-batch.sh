#!/bin/bash
#FLUX: --job-name=pusheena-car-2532
#FLUX: --queue=sbel_cmg
#FLUX: -t=1209690
#FLUX: --urgency=16

module load cuda/10.0
module load groupmods/cudnn/10.0
source activate deepchem
python /srv/home/xsun256/paper_comparison/le15/optimization/opt.py
