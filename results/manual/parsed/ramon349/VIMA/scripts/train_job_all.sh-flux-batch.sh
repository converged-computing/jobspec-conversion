#!/bin/bash
#FLUX: --job-name=confused-arm-1558
#FLUX: --urgency=16

module purge    
module load mamba 
source activate my_vima 
cd /home/rlcorrea/CSE574_project_vima/VIMA/scripts
python3 behavior_cloning_batched_v3.py
