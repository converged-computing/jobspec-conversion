#!/bin/bash
#FLUX: --job-name=Pump
#FLUX: -N=4
#FLUX: --queue=multiple
#FLUX: -t=43200
#FLUX: --urgency=16

export KMP_AFFINITY='compact,1,0'

export KMP_AFFINITY=compact,1,0
module load compiler/intel/19.1
module load mpi/openmpi/4.0
mpirun --bind-to core --map-by core -report-bindings $HOME/lammps-master/src/lmp_mpi -in $(pwd)/equilib.LAMMPS -v press 285
