#!/bin/bash
#FLUX: --job-name=conspicuous-house-6302
#FLUX: -N=2
#FLUX: --queue=maxwell
#FLUX: -t=3600
#FLUX: --urgency=16

source job-env.sh
srun --mpi=pmi2 ./mpi_jobs.py
