#!/bin/bash
#FLUX: --job-name=heat
#FLUX: -n=32
#FLUX: --urgency=16

module load mpi/openmpi-x86_64
mpirun -np $SLURM_NTASKS --map-by ppr:32:node --mca coll ^tuned ./main.mpi 8096 8096
