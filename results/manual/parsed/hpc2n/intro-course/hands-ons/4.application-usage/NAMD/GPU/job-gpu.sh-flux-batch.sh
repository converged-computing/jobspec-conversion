#!/bin/bash
#FLUX: --job-name=eccentric-despacito-4174
#FLUX: --priority=16

echo $CUDA_VISIBLE_DEVICES
ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration.inp > output_prod.dat
