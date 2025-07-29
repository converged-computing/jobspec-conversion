#!/bin/bash
#FLUX: --job-name=Ni_rose
#FLUX: -n=128
#FLUX: -t=86400
#FLUX: --urgency=16

pwd; hostname; date
module load intel/2018 
module load openmpi/3.1.2
OMPI_MCA_mpi_warn_on_fork=0
export OMPI_MCA_mpi_warn_on_fork
echo PYTHONPATH=$PYTHONPATH
echo python=$(which python)
echo PATH=$PATH
echo "start_time:$(date)"
srun --mpi=pmix_v1 python mc_iterative_sampler.py
echo "end_time:$(date)"
