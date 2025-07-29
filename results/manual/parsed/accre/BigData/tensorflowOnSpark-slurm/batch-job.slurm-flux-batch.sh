#!/bin/bash
#FLUX --job-name=swampy-malarkey-6525
#FLUX -N=2
#FLUX --queue=maxwell
#FLUX -t=3600
#FLUX --urgency=16

source job-env.sh
srun --mpi=pmi2 ./mpi_jobs.py
