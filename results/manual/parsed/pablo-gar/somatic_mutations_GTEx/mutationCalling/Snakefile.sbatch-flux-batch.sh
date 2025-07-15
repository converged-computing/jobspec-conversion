#!/bin/bash
#FLUX: --job-name=stinky-nunchucks-7276
#FLUX: --queue=hbfraser,hns,normal
#FLUX: -t=259200
#FLUX: --urgency=16

PATH=$HOME/bin:$PATH:$HOME/.local/bin:$HOME/gatk-4.0.3.0:$HOME/samtools_1.6/bin
export PATH
MODULEPATH=$MODULEPATH:/share/PI/hbfraser/modules/modules
export MODULEPATH
module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/mutationCalling/
date
echo "Start snakemake"
snakemake --keep-going --max-jobs-per-second 15 --restart-times 2 --max-status-checks-per-second 0.016 --nolock --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
date
echo "Snakemake done!"
