#!/bin/bash
#FLUX: --job-name=scruptious-ricecake-0246
#FLUX: -n=3
#FLUX: --urgency=16

. /opt/spack/20220821/share/spack/setup-env.sh
spack load scorep
srun bash -c 'SCOREP_ENABLE_TRACING=true mpiexec -n 3 ./partdiff 1 1 64 2 2 20'
