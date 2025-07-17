#!/bin/bash
#FLUX: --job-name=grated-leg-3158
#FLUX: --queue=hbfraser,hns,normal
#FLUX: -t=14400
#FLUX: --urgency=16

PATH=$HOME/bin:$PATH:$HOME/.local/bin:$HOME/gatk-4.0.3.0:$HOME/samtools_1.6/bin
export PATH
MODULEPATH=$MODULEPATH:/share/PI/hbfraser/modules/modules
export MODULEPATH
module load anaconda3
source activate fraserconda
cd ~/scripts/FraserLab/make_plink_1000genomes_phase_3_GRCh38/
snakemake --nolock --printshellcmds --keep-going --cluster-config ./cluster.json --cluster-status jobState --jobs 500 --cluster "./submit.py"
