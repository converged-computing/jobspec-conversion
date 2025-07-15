#!/bin/bash
#FLUX: --job-name=expressive-underoos-1806
#FLUX: --queue=hbfraser,hns,normal,owners
#FLUX: -t=86400
#FLUX: --priority=16

module load anaconda3
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/cancer/
snakemake --nolock --printshellcmds --keep-going --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
