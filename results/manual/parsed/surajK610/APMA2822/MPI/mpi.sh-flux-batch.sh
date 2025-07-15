#!/bin/bash
#FLUX: --job-name=delicious-hobbit-6038
#FLUX: -t=3600
#FLUX: --urgency=16

srun --mpi=pmix_v4 ex1
