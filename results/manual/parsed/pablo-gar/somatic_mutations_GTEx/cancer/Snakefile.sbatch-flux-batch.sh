#!/bin/bash
#FLUX: --job-name=purple-egg-1538
#FLUX: --queue=hbfraser,hns,normal,owners
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/cancer/
snakemake --nolock --printshellcmds --keep-going --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
