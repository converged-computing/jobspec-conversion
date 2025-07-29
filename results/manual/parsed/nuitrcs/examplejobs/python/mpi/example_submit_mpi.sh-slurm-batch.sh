#!/bin/bash
#FLUX: --job-name=sample_job
#FLUX: -N=2
#FLUX: --queue=w10001
#FLUX: -t=600
#FLUX: --urgency=16

module purge all
module load python-anaconda3
source activate slurm-py37-test
mpiexec -n ${SLURM_NTASKS} python -m mpi4py.bench helloworld
