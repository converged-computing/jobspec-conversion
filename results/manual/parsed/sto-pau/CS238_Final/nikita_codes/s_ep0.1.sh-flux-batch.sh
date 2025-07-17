#!/bin/bash
#FLUX: --job-name=policy_real
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
module load openmpi
module load anaconda3 
module load julia 
eval "$(conda shell.bash hook)"
conda activate env_CS238
cd /home/nkozak/CS238/explore_eps
python3 p_ep0.1.py 
