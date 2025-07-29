#!/bin/bash
#SBATCH --job-name=uk_modern
#SBATCH --account=ENV-TSUNAMI-2019
#SBATCH --output=thetis_%j.log
#SBATCH --mail-user=jon.hill@york.ac.uk
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

export LD_LIBRARY_PATH='/mnt/scratch/projects/env-tsunami-2019/firedrake_dec23/src/petsc/default/lib/:$LD_LIBRARY_PATH'
export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'

module load firedrake
unset PYTHONPATH
. /mnt/scratch/projects/env-tsunami-2019/firedrake_dec23/bin/activate
export LD_LIBRARY_PATH=/mnt/scratch/projects/env-tsunami-2019/firedrake_dec23/src/petsc/default/lib/:$LD_LIBRARY_PATH
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
mpiexec -n 32 python pre_processing.py
