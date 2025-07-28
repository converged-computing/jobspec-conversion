#!/bin/bash
#FLUX: --job-name=arid-buttface-5984
#FLUX: -t=7200
#FLUX: --urgency=16

module load python
source /nfs/home2/molenaar/spack/share/spack/setup-env.sh
spack load node-js
make run-udocker
