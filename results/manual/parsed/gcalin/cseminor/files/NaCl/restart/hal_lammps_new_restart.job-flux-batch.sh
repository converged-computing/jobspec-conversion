#!/bin/bash
#FLUX: --job-name=NaCl
#FLUX: -n=28
#FLUX: --queue=parallel-28
#FLUX: -t=604800
#FLUX: --urgency=16

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 28 $lmp/lmp_mpi < Simulation_new_restart.in
sleep 2
exit 0
