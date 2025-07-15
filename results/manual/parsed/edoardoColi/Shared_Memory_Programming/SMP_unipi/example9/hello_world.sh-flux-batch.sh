#!/bin/bash
#FLUX: --job-name=fugly-lamp-8726
#FLUX: --queue=normal
#FLUX: --priority=16

srun /bin/hostname
echo "running with srun on 4 nodes:"
srun --mpi=pmix ./hello_world
echo "running with mpirun on two nodes:"
mpirun -n 2 --report-bindings ./hello_world
