#!/bin/bash
#FLUX --job-name=crusty-leopard-6237
#FLUX -t=300
#FLUX --urgency=16

module load PrgEnv-nvidia
make clean ; make
srun -n 2 ./bcast_from_device
