#!/bin/bash
#FLUX: --job-name=faux-underoos-4721
#FLUX: --priority=16

time srun -N 1 -n 4 -c 8 shifter --image=docker:flagnarg/legacyhalos:latest ./hsc-mpi-shifter.sh
