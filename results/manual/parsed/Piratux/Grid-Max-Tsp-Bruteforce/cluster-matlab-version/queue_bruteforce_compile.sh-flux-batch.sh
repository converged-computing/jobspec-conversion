#!/bin/bash
#FLUX: --job-name=lovable-noodle-1955
#FLUX: -n=8
#FLUX: --queue=main
#FLUX: --urgency=16

module load openmpi
mpiCC -std=c++17 -O2 -o bruteforce-matlab-cluster bruteforce-matlab-cluster.cpp
