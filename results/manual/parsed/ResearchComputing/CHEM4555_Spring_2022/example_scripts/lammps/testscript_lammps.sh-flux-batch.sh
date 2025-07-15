#!/bin/bash
#FLUX: --job-name=lammps-test
#FLUX: -N=2
#FLUX: --queue=shas
#FLUX: -t=60
#FLUX: --priority=16

module purge
module load intel/17.4
module load impi/17.3
module load lammps/29Oct20
mpirun -np 2 lmp_mpi -in in.atm
