#!/bin/bash
#FLUX: --job-name=eccentric-lemur-6262
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

SEED=$((SLURM_ARRAY_TASK_ID))
echo $SEED
make processed_data/rf_genus_$SEED.Rds
