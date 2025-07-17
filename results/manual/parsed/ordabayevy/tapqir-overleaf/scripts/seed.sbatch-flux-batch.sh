#!/bin/bash
#FLUX: --job-name=seed
#FLUX: --urgency=16

python scripts/cosmos_simulations.py \
  --seed ${SLURM_ARRAY_TASK_ID} \
  --cuda \
  --path simulations/seed${SLURM_ARRAY_TASK_ID}
