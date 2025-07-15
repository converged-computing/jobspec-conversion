#!/bin/bash
#FLUX: --job-name=cvProject
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --urgency=16

module load cuda/9.2.88
module load anaconda3/5.3.1
source activate matrix
cd /scratch/ama1128/cvproject
python cvProject.py --epochs 50
