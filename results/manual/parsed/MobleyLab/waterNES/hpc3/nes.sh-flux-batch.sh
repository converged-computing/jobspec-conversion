#!/bin/bash
#FLUX: --job-name=moolicious-truffle-0289
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --priority=16

source ~/bin/gmx2022.1/bin/GMXRC
bash "$RUN_SCRIPT" -d "$SYSTEM_DIR"/stage"$STAGE" -t "$SYSTEM_DIR" -x gmx \
  -o "-ntmpi $SLURM_CPUS_PER_TASK" -s "$STAGE" -p NES -n "$SLURM_ARRAY_TASK_ID"
