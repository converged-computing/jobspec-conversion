#!/bin/bash
#FLUX: --job-name=H2O
#FLUX: -n=12
#FLUX: --queue=parallel-12
#FLUX: -t=604800
#FLUX: --urgency=16

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 12 $lmp/lmp_mpi < Simulation.in
sleep 2
exit 0
