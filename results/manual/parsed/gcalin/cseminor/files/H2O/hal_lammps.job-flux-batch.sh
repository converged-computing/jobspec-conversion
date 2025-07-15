#!/bin/bash
#FLUX: --job-name=crusty-bike-7155
#FLUX: --priority=16

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 12 $lmp/lmp_mpi < Simulation.in
sleep 2
exit 0
