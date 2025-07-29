#!/bin/bash
#FLUX: --job-name=CO2
#FLUX: -n=16
#FLUX: --queue=parallel-16
#FLUX: -t=604800
#FLUX: --urgency=16

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 16 $lmp/lmp_mpi < Simulation_new_restart_co2.in
sleep 2
exit 0
