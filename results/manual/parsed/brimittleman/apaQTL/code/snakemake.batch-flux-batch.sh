#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=broadwl
#FLUX: -t=86400
#FLUX: --priority=16

source ~/activate_anaconda.sh
conda activate three-prime-env
bash submit-snakemake.sh $*
