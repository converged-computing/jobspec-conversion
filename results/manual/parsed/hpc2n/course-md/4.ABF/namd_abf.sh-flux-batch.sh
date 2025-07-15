#!/bin/bash
#FLUX: --job-name=outstanding-lemon-7766
#FLUX: --exclusive
#FLUX: --urgency=16

ml purge > /dev/null 2>&1
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 abf.inp > output_abf.dat
