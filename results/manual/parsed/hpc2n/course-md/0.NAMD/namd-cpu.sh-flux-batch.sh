#!/bin/bash
#FLUX: --job-name=carnivorous-lizard-3428
#FLUX: --priority=16

ml purge > /dev/null 2>&1
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-mpi 
mpirun -np 28 namd2 config-file.inp > output_cpu.dat
