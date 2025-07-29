#!/bin/bash
#FLUX: --job-name=synergia2
#FLUX: --exclusive
#FLUX: --queue=gpu_gce
#FLUX: -t=1800
#FLUX: --urgency=16

module purge > /dev/null 2>&1
module load git
module load gnu11
module load cuda11
source /wclustre/accelsim/spack-shared-v4/setup_env_synergia-devel3-v100-002.sh
mpirun -np 1 ./wrapper_ompi.sh 
