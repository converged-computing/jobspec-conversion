#!/bin/bash
#FLUX: --job-name=blank-arm-0919
#FLUX: --queue=jnovembre
#FLUX: -t=345600
#FLUX: --urgency=16

module load python
source /software/python-anaconda-2020.02-el7-x86_64/etc/profile.d/conda.sh
conda activate snakemake
snakemake --cores 14 --nolock 
