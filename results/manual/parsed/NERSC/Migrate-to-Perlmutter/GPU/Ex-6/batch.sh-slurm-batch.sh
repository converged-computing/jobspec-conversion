#!/bin/bash
#FLUX: --job-name=wobbly-lamp-0804
#FLUX: -t=300
#FLUX: --urgency=16

module load PrgEnv-nvidia
make clean ; make
srun -n 2 ./bcast_from_device
