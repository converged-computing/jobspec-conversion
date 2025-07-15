#!/bin/bash
#FLUX: --job-name=faux-hope-6354
#FLUX: --urgency=16

export I_MPI_FABRICS='shm:tmi'

export I_MPI_FABRICS=shm:tmi
/usr/bin/time -v -o time_lmp_mpi.txt timeout 600 mpiexec -n 32 -ppn 8 -hosts bdw-0150,bdw-0151,bdw-0157,bdw-0158 /blues/gpfs/home/tshu/project/bebop/MPI_in_MPI/bebop-psm2/Example-LAMMPS/swift-all/lmp_mpi -i in.quench > output_lmp_mpi.txt 2>&1
