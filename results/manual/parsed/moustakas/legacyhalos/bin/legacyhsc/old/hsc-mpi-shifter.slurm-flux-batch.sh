#!/bin/bash
#FLUX: --job-name=butterscotch-rabbit-5770
#FLUX: --urgency=16

time srun -N 1 -n 4 -c 8 shifter --image=docker:flagnarg/legacyhalos:latest ./hsc-mpi-shifter.sh
