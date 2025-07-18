#!/bin/bash
#FLUX: --job-name=testONEAPI
#FLUX: -N=2
#FLUX: --queue=normal
#FLUX: --urgency=16

export FI_PROVIDER='tcp'

pwd; hostname; date
export FI_PROVIDER=tcp
source /opt/intel/oneapi/setvars.sh
cd /home/omnia-share/mp_linpack
srun -N 2 --mpi=pmix -n 2 xhpl_intel64_dynamic
date
