#!/bin/bash
#FLUX: --job-name=pusheena-ricecake-8974
#FLUX: --urgency=16

module load openmpi
mpiCC -std=c++17 -O2 -o bruteforce-matlab-cluster bruteforce-matlab-cluster.cpp
