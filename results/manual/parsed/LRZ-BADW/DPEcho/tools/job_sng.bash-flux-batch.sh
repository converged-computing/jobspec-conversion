#!/bin/bash
#FLUX: --job-name=echo
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load slurm_setup
module load spack/23
module load intel-toolkit
source ../LRZoneAPI.sh # Takes care of modules
./dpecho_gpu
exit
