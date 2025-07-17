#!/bin/bash
#FLUX: --job-name=Z
#FLUX: -n=20
#FLUX: --queue=normal
#FLUX: -t=43200
#FLUX: --urgency=16

for i in {1..10}; do
RAND=$(echo $RANDOM)  # random initial velocity seed
mpirun lmp_mpi < X -var random $RAND -var iter $i -var name Z
done
