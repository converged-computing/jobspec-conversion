#!/bin/bash
#FLUX: --job-name=expressive-arm-9449
#FLUX: --urgency=16

cd /work/mh0033/m300883/Tel_MMLE/script/8season
source ~/.bashrc
source activate TelSeason
LD_LIBRARY_PATH=/home/m/m300883/libraries
module load openmpi/4.1.2-intel-2021.5.0
srun -n 30 --mpi=pmi2 env MPICC=/sw/spack-levante/openmpi-4.1.2-yfwe6t/bin/mpicc python -m mpi4py hello1index_generator_500hpa.py
