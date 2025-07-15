#!/bin/bash
#FLUX: --job-name=ppahs
#FLUX: --priority=16

cd /project/fsepru/paul.villanueva/repos/ppahs
source /home/${USER}/.bashrc
source activate snakemake
date
time snakemake --use-conda --profile workflow/profile -p 
date
