#!/bin/bash
#FLUX --job-name=loopy-nunchucks-2635
#FLUX -N=2
#FLUX --queue=parallel
#FLUX -t=86400
#FLUX --urgency=16

module purge
module load goolf namd
mpiexec namd2 input.namd       # please use mpiexec as the executor for NAMD
