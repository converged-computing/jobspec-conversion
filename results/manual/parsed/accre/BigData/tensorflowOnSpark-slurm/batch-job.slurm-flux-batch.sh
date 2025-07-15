#!/bin/bash
#FLUX: --job-name=muffled-underoos-8200
#FLUX: -N=2
#FLUX: --queue=maxwell
#FLUX: -t=3600
#FLUX: --priority=16

source job-env.sh
srun --mpi=pmi2 ./mpi_jobs.py
