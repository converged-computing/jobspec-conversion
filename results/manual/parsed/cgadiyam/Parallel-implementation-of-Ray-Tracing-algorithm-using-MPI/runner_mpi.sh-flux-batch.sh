#!/bin/bash
#FLUX: --job-name=delicious-avocado-2142
#FLUX: --priority=16

module load openmpi-x86_64
mpirun -np $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/twhitted.xml -p dynamic -bh 50 -bw 50 
