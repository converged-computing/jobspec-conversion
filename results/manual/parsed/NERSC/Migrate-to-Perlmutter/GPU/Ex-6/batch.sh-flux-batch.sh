#!/bin/bash
#FLUX: --job-name=delicious-animal-6415
#FLUX: --priority=16

module load PrgEnv-nvidia
make clean ; make
srun -n 2 ./bcast_from_device
