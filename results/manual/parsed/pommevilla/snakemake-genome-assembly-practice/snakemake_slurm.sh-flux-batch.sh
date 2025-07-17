#!/bin/bash
#FLUX: --job-name=snakemake_run
#FLUX: -n=48
#FLUX: --queue=medium
#FLUX: -t=172800
#FLUX: --urgency=16

cd /project/fsepru/paul.villanueva/repos/snakemake-genome-assembly-practice
source /home/${USER}/.bashrc
source activate snakemake
date
time snakemake --use-conda --profile slurm -p
date
