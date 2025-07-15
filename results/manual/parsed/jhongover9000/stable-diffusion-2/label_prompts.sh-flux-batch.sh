#!/bin/bash
#FLUX: --job-name=purple-mango-1927
#FLUX: -c=4
#FLUX: -t=259200
#FLUX: --urgency=16

FILES=(/scratch/jhh508/stable-diffusion-2/*)
module purge
cd /scratch/jhh508/stable-diffusion-2/prompt-labeling/
pwd
eval "$(conda shell.bash hook)"
conda init bash
conda activate stable-diff
module load gcc
echo loaded
chmod +x promptLabeler.py
python promptLabeler.py promptList_full.txt labelList_full_v2.txt
