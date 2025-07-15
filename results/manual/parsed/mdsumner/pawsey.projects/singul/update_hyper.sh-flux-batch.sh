#!/bin/bash
#FLUX: --job-name=crusty-muffin-3185
#FLUX: -c=2
#FLUX: --queue=copy
#FLUX: -t=3600
#FLUX: --priority=16

module load singularity/3.11.4-slurm
mv  $MYSOFTWARE/sif_lib/hypertidy_main.sif  $MYSOFTWARE/sif_lib/hypertidy_main_`date -I`.sif
singularity pull --dir $MYSOFTWARE/sif_lib docker://mdsumner/hypertidy:main
