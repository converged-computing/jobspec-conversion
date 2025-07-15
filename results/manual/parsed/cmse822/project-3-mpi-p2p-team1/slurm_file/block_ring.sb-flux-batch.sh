#!/bin/bash
#FLUX: --job-name=block_ring
#FLUX: -N=2
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load GCC/6.4.0 OpenMPI/2.1.2
for i in $(seq 1 8); do 
    let ntasks=2**$i
    mpiexec -n $ntasks block_ring > block_ring_${ntasks}processors.csv
    echo "processes=$i is finished"
done
