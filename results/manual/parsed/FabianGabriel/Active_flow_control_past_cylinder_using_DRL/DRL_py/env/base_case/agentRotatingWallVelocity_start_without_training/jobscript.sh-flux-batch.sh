#!/bin/bash
#FLUX: --job-name=no_train
#FLUX: --queue=standard
#FLUX: -t=28800
#FLUX: --urgency=16

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
cd ./env/run/sample_*/
./Allrun.singularity
touch finished.txt
