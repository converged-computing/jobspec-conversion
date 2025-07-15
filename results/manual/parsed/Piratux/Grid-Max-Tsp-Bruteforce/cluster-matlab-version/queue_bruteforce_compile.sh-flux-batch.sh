#!/bin/bash
#FLUX: --job-name=faux-motorcycle-3940
#FLUX: --priority=16

module load openmpi
mpiCC -std=c++17 -O2 -o bruteforce-matlab-cluster bruteforce-matlab-cluster.cpp
