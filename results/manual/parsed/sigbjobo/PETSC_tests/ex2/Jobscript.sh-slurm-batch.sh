#!/bin/bash
#FLUX: --job-name=DNA
#FLUX: --queue=normal
#FLUX: -t=1800
#FLUX: --urgency=16

module load PETSc/3.4.4
make clean
make
mpiexec -n 2 test
exit 0
