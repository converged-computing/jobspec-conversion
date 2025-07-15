#!/bin/bash
#FLUX: --job-name=conspicuous-parsnip-6975
#FLUX: --exclusive
#FLUX: --priority=16

ml purge > /dev/null 2>&1
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 config-file.inp > output_gpu.dat
