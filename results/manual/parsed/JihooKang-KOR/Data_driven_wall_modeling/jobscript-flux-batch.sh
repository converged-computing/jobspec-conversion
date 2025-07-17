#!/bin/bash
#FLUX: --job-name=channel1D
#FLUX: --queue=standard
#FLUX: -t=432000
#FLUX: --urgency=16

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
echo "Submitting case $1"
cd run/$1
image="../../../of2106.sif"
bashrc="/usr/lib/openfoam/openfoam2106/etc/bashrc"
singularity exec $image bash -c "source $bashrc && ./Allrun_1D"
