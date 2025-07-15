#!/bin/bash
#FLUX: --job-name=expressive-diablo-6517
#FLUX: -c=5
#FLUX: --queue=partition
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

date +"%d %B %Y %H:%M:%S"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
source ~/.bash_profile
Rscript $protocol_dir/STAR_protocols_GV_calling/scripts/determineVariantStatus.R $SLURM_ARRAY_TASK_ID
date +"%d %B %Y %H:%M:%S"
