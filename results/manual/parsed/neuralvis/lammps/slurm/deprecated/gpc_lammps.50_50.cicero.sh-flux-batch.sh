#!/bin/bash
#FLUX: --job-name=gpc_lammps.001
#FLUX: -N=154
#FLUX: --queue=iv24
#FLUX: -t=21600
#FLUX: --urgency=16

module load PrgEnv-cray
module load cray-mpich
module load perftools-base perftools
srun --exclusive -N 77 -n 770 \
     /home/users/msrinivasa/develop/GPCNET/network_load_test > gpc.out &
sleep 10
srun --exclusive -N 77 -n 308 \
     /home/users/msrinivasa/develop/lammps/build/lmp+trace \
     -i /home/users/msrinivasa/develop/lammps/examples/DIFFUSE/in.msd.2d > lammps.out
wait
