#!/bin/bash
#FLUX: --job-name=confused-earthworm-9078
#FLUX: --queue=cmain
#FLUX: --urgency=16

module purge
module load gcc cuda mvapich2/2.2
NAMD="/projects/jdb252_1/tj227/bin/namd2-2.13-gcc-mvapich2"
SRUN="srun --mpi=pmi2"
$SRUN $NAMD starting.POEG_7.namd > starting.POEG_7.log
