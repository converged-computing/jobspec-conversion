#!/bin/bash
#FLUX --job-name=hello-kerfuffle-5169
#FLUX -t=300
#FLUX --urgency=16

module load PrgEnv-nvidia
make clean ; make
srun -n 2 ./bcast_from_device
