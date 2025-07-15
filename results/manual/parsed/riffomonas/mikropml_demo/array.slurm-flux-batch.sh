#!/bin/bash
#FLUX: --job-name=outstanding-motorcycle-2722
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --priority=16

SEED=$((SLURM_ARRAY_TASK_ID))
echo $SEED
make processed_data/l2_genus_$SEED.Rds
