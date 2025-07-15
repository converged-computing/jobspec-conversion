#!/bin/bash
#FLUX: --job-name=pusheena-leopard-6849
#FLUX: --urgency=16

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 12 $lmp/lmp_mpi < Simulation_5_restart.in
sleep 2
exit 0
