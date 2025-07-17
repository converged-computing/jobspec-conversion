#!/bin/bash
#FLUX: --job-name=fugly-leader-5498
#FLUX: -n=28
#FLUX: -t=600
#FLUX: --urgency=16

ml purge > /dev/null 2>&1
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-mpi 
mpirun -np 28 namd2 config-file.inp > output_cpu.dat
