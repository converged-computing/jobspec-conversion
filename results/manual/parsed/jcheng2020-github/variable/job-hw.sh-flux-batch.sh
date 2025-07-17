#!/bin/bash
#FLUX: --job-name=scruptious-eagle-7618
#FLUX: -t=300
#FLUX: --urgency=16

srun --mpi=pmix_v3 ./adam.out 500000
