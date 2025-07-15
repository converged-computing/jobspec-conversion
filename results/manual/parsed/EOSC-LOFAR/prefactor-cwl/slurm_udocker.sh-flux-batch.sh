#!/bin/bash
#FLUX: --job-name=cowy-milkshake-2132
#FLUX: --priority=16

module load python
source /nfs/home2/molenaar/spack/share/spack/setup-env.sh
spack load node-js
make run-udocker
