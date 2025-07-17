#!/bin/bash
#FLUX: --job-name=chunky-staircase-6087
#FLUX: --queue=hbfraser,hns,normal
#FLUX: -t=43200
#FLUX: --urgency=16

module load anaconda3
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/methodValidation/
date
echo "Start snakemake"
snakemake --nolock --restart-times 1 --keep-going --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
date
echo "Snakemake done!"
