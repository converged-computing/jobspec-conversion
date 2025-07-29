#!/bin/bash
#SBATCH --output=GS_3x2.out
#SBATCH --nodes=2
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1

. /opt/spack/20220821/share/spack/setup-env.sh
spack load scorep
srun bash -c 'SCOREP_ENABLE_TRACING=true mpiexec -n 3 ./partdiff 1 1 64 2 2 20'
