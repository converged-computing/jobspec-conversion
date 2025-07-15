#!/bin/bash
#FLUX: --job-name=rest2
#FLUX: --queue=yethiraj
#FLUX: -t=43200
#FLUX: --priority=16

nrep=4
mpirun -n $nrep gmx_mpi mdrun -v -plumed ../plumed.dat -multidir topol0 topol1 topol2 topol3 -replex 500 -maxh 12 -hrex -dlb no
