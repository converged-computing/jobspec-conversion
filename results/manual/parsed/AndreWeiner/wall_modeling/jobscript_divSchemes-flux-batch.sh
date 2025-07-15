#!/bin/bash
#FLUX: --job-name=plate
#FLUX: --queue=standard
#FLUX: -t=432000
#FLUX: --priority=16

export model_num='$2'

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
echo "Submitting case $1"
cd run/$1
export model_num=$2
./Allrun_divSchemes.singularity
