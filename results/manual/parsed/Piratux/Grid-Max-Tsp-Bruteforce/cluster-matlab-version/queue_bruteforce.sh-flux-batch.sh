#!/bin/bash
#FLUX: --job-name=fat-earthworm-6873
#FLUX: -N=20
#FLUX: --queue=main
#FLUX: -t=1800
#FLUX: --urgency=16

module load openmpi
mpiCC -std=c++17 -O2 -o bruteforce-matlab-cluster bruteforce-matlab-cluster.cpp
mpirun -n 960 bruteforce-matlab-cluster
