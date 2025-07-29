#!/bin/bash
#FLUX --job-name=carnivorous-bicycle-1208
#FLUX -n=8
#FLUX --queue=main
#FLUX --urgency=16

module load openmpi
mpiCC -std=c++17 -O2 -o bruteforce-matlab-cluster bruteforce-matlab-cluster.cpp
