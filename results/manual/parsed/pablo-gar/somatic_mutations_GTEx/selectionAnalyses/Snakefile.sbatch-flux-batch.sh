#!/bin/bash
#FLUX: --job-name=milky-butter-9289
#FLUX: --queue=hbfraser,owners,hns,normal
#FLUX: -t=86400
#FLUX: --urgency=16

module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/selectionAnalyses/
snakemake --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --cluster-config ../cluster.json --cluster-status jobState --jobs 1000 --keep-going --cluster "../submit.py"
