#!/bin/bash
#FLUX: --job-name=swampy-leader-5859
#FLUX: --queue=main
#FLUX: --urgency=16

module load openmpi
mpiCC -std=c++17 -O2 -o bruteforce-matlab-cluster bruteforce-matlab-cluster.cpp
