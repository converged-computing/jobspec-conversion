#!/bin/bash
#FLUX: --job-name=persnickety-destiny-2135
#FLUX: -n=28
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

ml purge > /dev/null 2>&1
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 config-file.inp > output_gpu.dat
