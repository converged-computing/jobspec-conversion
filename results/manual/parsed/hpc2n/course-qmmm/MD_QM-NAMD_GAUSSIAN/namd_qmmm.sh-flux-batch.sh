#!/bin/bash
#FLUX: --job-name=strawberry-hobbit-3643
#FLUX: -n=28
#FLUX: -t=3000
#FLUX: --urgency=16

ml purge  > /dev/null 2>&1 
ml gaussian/16.C.01-AVX2
ml GCC/9.3.0  OpenMPI/4.0.3
ml SciPy-bundle/2020.03-Python-2.7.18
ml NAMD/2.14-mpi
mpirun -np 28 namd2 4ake_eq_qmmm.conf > logfile_qmmm.txt
