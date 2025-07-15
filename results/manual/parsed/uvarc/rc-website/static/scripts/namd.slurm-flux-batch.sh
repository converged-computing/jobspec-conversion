#!/bin/bash
#FLUX: --job-name=scruptious-knife-1376
#FLUX: --urgency=16

module purge
module load goolf namd
mpiexec namd2 input.namd       # please use mpiexec as the executor for NAMD
