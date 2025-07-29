#!/bin/bash
#SBATCH --job-name=bsl_highres_combi
#SBATCH --output=./%x.%j.out
#SBATCH --error=./%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --chdir=./
#SBATCH: --no-requeue

export LD_LIBRARY_PATH='$(pwd)/../../../lib/sgpp:$(pwd)/../../../glpk/lib:$LD_LIBRARY_PATH'
export OMP_NUM_THREADS='1'

export LD_LIBRARY_PATH=$(pwd)/../../../lib/sgpp:$(pwd)/../../../glpk/lib:$LD_LIBRARY_PATH
export OMP_NUM_THREADS=1
. ~/spack/share/spack/setup-env.sh
spack load boost@1.74.0
spack load hdf5@1.10.5
mpiexec.openmpi -n $SLURM_NTASKS ./selalib_distributed
