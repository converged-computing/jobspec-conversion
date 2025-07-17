#!/bin/bash
#FLUX: --job-name=cowy-citrus-8973
#FLUX: -c=4
#FLUX: --queue=general
#FLUX: -t=43200
#FLUX: --urgency=16

module purge    
module load mamba 
source activate my_vima 
cd /home/rlcorrea/CSE574_project_vima/VIMA/scripts
python3 behavior_cloning_batched_v2.py
