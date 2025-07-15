#!/bin/bash
#FLUX: --job-name=boopy-malarkey-5178
#FLUX: --queue=test -t 30
#FLUX: --priority=16

module purge
module load slurm_setup
module load spack/23
module load intel-toolkit
source ../LRZoneAPI.sh # Takes care of modules
./dpecho_gpu
exit
