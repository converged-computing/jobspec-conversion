#!/bin/bash
#FLUX: --job-name=test_mpi
#FLUX: -t=60
#FLUX: --priority=16

srun --mpi=pmix hello.mpi
