#!/bin/bash
#FLUX: --job-name=spack-install
#FLUX: -c=2
#FLUX: --queue=reservation
#FLUX: -t=3600
#FLUX: --priority=16

module load python/3.8.1
source ~/spack/share/spack/setup-env.sh
source ~/spack/share/spack/setup-env.sh
spack load tcl
echo $PATH
