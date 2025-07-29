#!/bin/bash
#SBATCH --job-name=CO2
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00

lmp=/home/noura/LAMMPS/tests/src_v05
mpi=/usr/local/openmpi-1.8.4-ifort/bin
$mpi/mpirun -np 28 $lmp/lmp_mpi < Simulation_new.in
sleep 2
exit 0
