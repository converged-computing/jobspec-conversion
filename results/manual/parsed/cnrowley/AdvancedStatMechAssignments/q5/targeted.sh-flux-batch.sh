#!/bin/bash
#FLUX: --job-name=targeted
#FLUX: -n=8
#FLUX: -t=43200
#FLUX: --priority=16

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p8 tip4p-methanol-targeted.conf > tip4p-methanol-targeted.out
