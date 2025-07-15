#!/bin/bash
#FLUX: --job-name=milky-leg-3014
#FLUX: --priority=16

module purge    
module load mamba 
source activate my_vima 
cd /home/rlcorrea/CSE574_project_vima/VIMA/scripts
python3 behavior_cloning_batched_v2.py
