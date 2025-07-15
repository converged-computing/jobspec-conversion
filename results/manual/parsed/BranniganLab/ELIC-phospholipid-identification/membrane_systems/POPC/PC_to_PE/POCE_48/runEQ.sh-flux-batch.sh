#!/bin/bash
#FLUX: --job-name=moolicious-signal-3610
#FLUX: --queue=cmain
#FLUX: --priority=16

module purge
module load gcc cuda mvapich2/2.2
NAMD="/projects/jdb252_1/tj227/bin/namd2-2.13-gcc-mvapich2"
SRUN="srun --mpi=pmi2"
$SRUN $NAMD starting.POCE_48.namd > starting.POCE_48.log
