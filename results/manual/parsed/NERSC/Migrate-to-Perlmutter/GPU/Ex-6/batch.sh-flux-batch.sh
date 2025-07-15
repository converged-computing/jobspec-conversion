#!/bin/bash
#FLUX: --job-name=quirky-itch-1916
#FLUX: --urgency=16

module load PrgEnv-nvidia
make clean ; make
srun -n 2 ./bcast_from_device
