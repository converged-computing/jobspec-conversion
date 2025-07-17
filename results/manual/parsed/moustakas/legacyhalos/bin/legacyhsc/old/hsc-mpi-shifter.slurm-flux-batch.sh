#!/bin/bash
#FLUX: --job-name=salted-itch-6702
#FLUX: -n=4
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

time srun -N 1 -n 4 -c 8 shifter --image=docker:flagnarg/legacyhalos:latest ./hsc-mpi-shifter.sh
