#!/bin/bash
#FLUX: --job-name=Tit
#FLUX: -c=48
#FLUX: --queue=batch
#FLUX: -t=345600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
source /apps/lmod/lmod/init/zsh
ml Python/3.8.2-GCCcore-8.3.
ml STAR
ml BEDTools
ml SAMtools 
ml bioawk 
ml Trimmomatic
ml snakemake
ml BLAST+
ml Anaconda3
source activate snakemake_6
