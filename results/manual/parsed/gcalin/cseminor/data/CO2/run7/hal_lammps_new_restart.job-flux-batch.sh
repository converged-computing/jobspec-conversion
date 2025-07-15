#!/bin/bash
#FLUX: --job-name=crusty-ricecake-0995
#FLUX: --urgency=16

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 28 $lmp/lmp_mpi < Simulation_new_restart_co2.in
sleep 2
exit 0
