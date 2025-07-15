#!/bin/bash
#FLUX: --job-name=stinky-citrus-1508
#FLUX: --priority=16

module purge
module load goolf namd
mpiexec namd2 input.namd       # please use mpiexec as the executor for NAMD
