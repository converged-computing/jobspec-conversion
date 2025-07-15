#!/bin/bash
#FLUX: --job-name=expressive-sundae-5718
#FLUX: --urgency=16

srun --mpi=pmix_v3 ./adam.out 500000
