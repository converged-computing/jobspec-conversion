#!/bin/bash
#FLUX: --job-name=namd
#FLUX: -n=28
#FLUX: --exclusive
#FLUX: -t=480
#FLUX: --urgency=16

ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration.inp > output_gpu1.dat
namd2 +p28 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration_mts.inp > output_gpu2.dat
