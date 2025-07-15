#!/bin/bash
#FLUX: --job-name=stanky-pancake-7813
#FLUX: --queue=hbfraser,hns,normal
#FLUX: -t=86400
#FLUX: --priority=16

module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/chromatin/
snakemake --restart-times 1 --nolock --printshellcmds --keep-going --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
