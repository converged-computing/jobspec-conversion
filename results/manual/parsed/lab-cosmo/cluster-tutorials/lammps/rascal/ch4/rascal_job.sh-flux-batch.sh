#!/bin/bash
#FLUX: --job-name=ipi
#FLUX: -c=4
#FLUX: --queue=jobs
#FLUX: -t=600
#FLUX: --priority=16

module purge
module load gcc
module load lammps
mpirun -n 1 lmp_mpi -i ch4.in.lammps
exit 0
