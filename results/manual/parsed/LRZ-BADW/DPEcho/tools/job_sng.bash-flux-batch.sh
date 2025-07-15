#!/bin/bash
#FLUX: --job-name=crunchy-truffle-1982
#FLUX: --queue=test
#FLUX: --urgency=16

module purge
module load slurm_setup
module load spack/23
module load intel-toolkit
source ../LRZoneAPI.sh # Takes care of modules
./dpecho_gpu
exit
