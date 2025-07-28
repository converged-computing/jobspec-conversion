#!/bin/bash
#FLUX: --job-name=persnickety-peanut-3451
#FLUX: -t=300
#FLUX: --urgency=16

srun --mpi=pmix_v3 ./adam.out 500000
