#!/bin/bash
#FLUX: --job-name=synergia2
#FLUX: --exclusive
#FLUX: --queue=gpu_gce
#FLUX: -t=1800
#FLUX: --urgency=16

module purge > /dev/null 2>&1
module load gcc/12.3.0
source /wclustre/accelsim/spack_013024/envs/synergia-devel3-gpu-v100-ompi.sh
mpirun -np 1 ./wrapper_ompi.sh 
