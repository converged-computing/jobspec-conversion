#!/bin/bash
#SBATCH --output=np-4-4096.out
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --nodelist=node-01,node-02,node-03,node-04,node-05

mpirun --mca btl_tcp_if_exclude docker0,lo -np 5 jacobi-np4-4096 -- 4096 10000
