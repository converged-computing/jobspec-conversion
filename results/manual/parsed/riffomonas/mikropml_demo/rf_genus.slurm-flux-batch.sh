#!/bin/bash
#FLUX: --job-name=strawberry-staircase-5643
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --priority=16

SEED=$((SLURM_ARRAY_TASK_ID))
echo $SEED
make processed_data/rf_genus_$SEED.Rds
