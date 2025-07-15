#!/bin/bash
#FLUX: --job-name=fugly-plant-2639
#FLUX: -c=12
#FLUX: -t=3000
#FLUX: --priority=16

module load StdEnv/2023
module load cuda/12.2
./namd3 +p$SLURM_CPUS_PER_TASK  +idlepoll stmv.namd
