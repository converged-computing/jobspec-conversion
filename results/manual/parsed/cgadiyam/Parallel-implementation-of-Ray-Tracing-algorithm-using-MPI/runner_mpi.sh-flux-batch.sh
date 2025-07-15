#!/bin/bash
#FLUX: --job-name=fugly-peanut-8472
#FLUX: --urgency=16

module load openmpi-x86_64
mpirun -np $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/twhitted.xml -p dynamic -bh 50 -bw 50 
