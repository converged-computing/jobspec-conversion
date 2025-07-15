#!/bin/bash
#FLUX: --job-name=ornery-kerfuffle-7419
#FLUX: --urgency=16

module purge    
module load mamba 
source activate my_vima 
cd /home/rlcorrea/CSE574_project_vima/VIMA/scripts
python3 behavior_cloning_batched_v2.py
