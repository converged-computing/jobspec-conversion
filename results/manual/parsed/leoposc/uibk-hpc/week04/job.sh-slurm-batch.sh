#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=96
#FLUX: --exclusive
#FLUX: --queue=lva
#FLUX: --urgency=16

ns=(768)
rs=(96)
module purge
module load openmpi/3.1.6-gcc-12.2.0-d2gmn55
for n in "${ns[@]}"
do
    for r in "${rs[@]}"
    do
      mpiexec -np $r ./bin/heat_stencil_2D_mpi $n
    done
done
