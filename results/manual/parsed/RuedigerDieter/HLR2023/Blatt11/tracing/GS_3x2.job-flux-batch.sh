#!/bin/bash
#FLUX: --job-name=pusheena-motorcycle-5214
#FLUX: -N=2
#FLUX: -n=3
#FLUX: --queue=west
#FLUX: --urgency=16

. /opt/spack/20220821/share/spack/setup-env.sh
spack load scorep
srun bash -c 'SCOREP_ENABLE_TRACING=true mpiexec -n 3 ./partdiff 1 1 64 2 2 20'
