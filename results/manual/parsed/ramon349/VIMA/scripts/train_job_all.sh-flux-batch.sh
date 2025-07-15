#!/bin/bash
#FLUX: --job-name=moolicious-diablo-2686
#FLUX: --priority=16

module purge    
module load mamba 
source activate my_vima 
cd /home/rlcorrea/CSE574_project_vima/VIMA/scripts
python3 behavior_cloning_batched_v3.py
