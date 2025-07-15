#!/bin/bash
#FLUX: --job-name=grated-pastry-2057
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

SEED=$((SLURM_ARRAY_TASK_ID))
echo $SEED
make processed_data/l2_genus_$SEED.Rds
