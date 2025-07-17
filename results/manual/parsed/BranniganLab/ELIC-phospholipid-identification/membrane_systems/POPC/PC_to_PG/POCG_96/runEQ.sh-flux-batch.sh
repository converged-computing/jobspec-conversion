#!/bin/bash
#FLUX: --job-name=EQ_POCG_96
#FLUX: -N=3
#FLUX: -n=96
#FLUX: --queue=cmain
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load gcc cuda mvapich2/2.2
NAMD="/projects/jdb252_1/tj227/bin/namd2-2.13-gcc-mvapich2"
SRUN="srun --mpi=pmi2"
$SRUN $NAMD starting.POCG_96.namd > starting.POCG_96.log
