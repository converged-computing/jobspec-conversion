#!/bin/bash
#FLUX: --job-name=test_mpi
#FLUX: -t=60
#FLUX: --urgency=16

srun --mpi=pmix hello.mpi
