#!/bin/bash
#FLUX: --job-name=b0d135
#FLUX: --queue=gpu
#FLUX: --urgency=16

export SINGULARITY_NV='1'

module load singularity
export SINGULARITY_NV=1
module load centos
module load extra
module load GCC
module load cuda/9.1
centos.sh "module load cuda/9.1; ./virus-model -dt=0.001 Data_structure.xml"
