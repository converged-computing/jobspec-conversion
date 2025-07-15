#!/bin/bash
#FLUX: --job-name=arid-destiny-0583
#FLUX: -t=3600
#FLUX: --priority=16

srun --mpi=pmix_v4 ex1
