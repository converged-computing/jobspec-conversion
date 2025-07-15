#!/bin/bash
#FLUX: --job-name=peachy-truffle-5477
#FLUX: --priority=16

ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  OpenMPI/4.0.3
ml NAMD/2.14-mpi 
srun namd2 step4_equilibration.inp > output_mpi1.dat
srun namd2 step4_equilibration_mts.inp > output_mpi2.dat
