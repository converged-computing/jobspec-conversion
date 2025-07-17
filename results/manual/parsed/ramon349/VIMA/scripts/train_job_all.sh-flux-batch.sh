#!/bin/bash
#FLUX: --job-name=psycho-bicycle-7766
#FLUX: -c=8
#FLUX: --queue=general
#FLUX: -t=32400
#FLUX: --urgency=16

module purge    
module load mamba 
source activate my_vima 
cd /home/rlcorrea/CSE574_project_vima/VIMA/scripts
python3 behavior_cloning_batched_v3.py
