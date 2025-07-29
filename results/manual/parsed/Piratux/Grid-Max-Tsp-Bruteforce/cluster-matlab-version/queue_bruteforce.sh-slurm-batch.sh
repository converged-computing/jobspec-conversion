#!/bin/bash
#SBATCH --nodes=20
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=48

module load openmpi
mpiCC -std=c++17 -O2 -o bruteforce-matlab-cluster bruteforce-matlab-cluster.cpp
mpirun -n 960 bruteforce-matlab-cluster
