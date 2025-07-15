#!/bin/bash
#FLUX: --job-name=gpc_lammps.001
#FLUX: -N=927
#FLUX: --queue=workq
#FLUX: -t=21600
#FLUX: --priority=16

module restore PrgEnv-cray
module load cray-mpich/8.0.15
srun --exclusive -N 93 -n 372 \
     /home/users/msrinivasa/develop/lammps/build/lmp+tracing \
     -i /home/users/msrinivasa/develop/lammps/examples/DIFFUSE/in.msd.2d > lammps.out
