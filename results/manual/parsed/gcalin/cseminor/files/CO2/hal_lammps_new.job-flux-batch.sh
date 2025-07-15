#!/bin/bash
#FLUX: --job-name=butterscotch-caramel-3425
#FLUX: --priority=16

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 28 $lmp/lmp_mpi < Simulation_new.in
sleep 2
exit 0
