#!/bin/bash
#FLUX: --job-name=rt_mpi
#FLUX: -n=16
#FLUX: --queue=class
#FLUX: --urgency=16

module load openmpi-x86_64
mpirun -np $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/twhitted.xml -p dynamic -bh 50 -bw 50 
