#!/bin/bash
#FLUX: --job-name=ppahs
#FLUX: -n=12
#FLUX: --queue=short
#FLUX: -t=28800
#FLUX: --urgency=16

cd /project/fsepru/paul.villanueva/repos/ppahs
source /home/${USER}/.bashrc
source activate snakemake
date
time snakemake --use-conda --profile workflow/profile -p 
date
