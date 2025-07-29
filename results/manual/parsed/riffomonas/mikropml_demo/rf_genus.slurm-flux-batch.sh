#!/bin/bash
#FLUX --job-name=pusheena-spoon-0665
#FLUX --queue=standard
#FLUX -t=86400
#FLUX --urgency=16

SEED=$((SLURM_ARRAY_TASK_ID))
echo $SEED
make processed_data/rf_genus_$SEED.Rds
