#!/bin/bash
#FLUX: --job-name=mov
#FLUX: -n=10
#FLUX: --queue=hpg2-compute
#FLUX: -t=10800
#FLUX: --priority=16

module purge
module load intel/2018.1.163 gsl/2.4 openmpi/3.1.2 python3
module list
mpirun -n 10 python make_movie.py 
