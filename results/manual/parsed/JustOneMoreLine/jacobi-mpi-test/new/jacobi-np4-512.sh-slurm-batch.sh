#!/bin/bash
#SBATCH --output=jacobi-np4-512.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --nodelist=node-01

mpirun --mca btl_tcp_if_exclude docker0,lo -np 5 jacobi-mpi 512 100
