#!/bin/bash
#FLUX: --job-name=axpyMPI
#FLUX: -n=4
#FLUX: --queue=workshop
#FLUX: -t=300
#FLUX: --priority=16

module load intel/20.0.0
module load eb/OpenMPI/intel/3.1.1
mpirun ./axpyMPI.exe
