#!/bin/bash
#FLUX: --job-name=razi
#FLUX: -c=24
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

date
ml Anaconda3
ml snakemake
ml DIAMOND
cd $SLURM_SUBMIT_DIR
conda init bash
source ~/.bashrc
conda activate snakemake
snakemake --cores all
date
