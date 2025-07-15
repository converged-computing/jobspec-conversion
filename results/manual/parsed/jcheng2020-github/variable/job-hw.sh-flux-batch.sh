#!/bin/bash
#FLUX: --job-name=nerdy-rabbit-7282
#FLUX: --priority=16

srun --mpi=pmix_v3 ./adam.out 500000
