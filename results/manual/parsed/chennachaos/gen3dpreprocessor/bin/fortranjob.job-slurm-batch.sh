#!/bin/bash
#SBATCH --job-name=parallelfort
#SBATCH --output=fortran-partition.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5000
#SBATCH --time=05:00:00

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/app/libraries/petsc/3.7.5/el6/AVX/intel-16.0/intel-5.1/lib'

module purge
module load hpcw
module load petsc/3.7.5
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/app/libraries/petsc/3.7.5/el6/AVX/intel-16.0/intel-5.1/lib
echo My job is started
mpirun ./partfort m6 10
echo My job has finished
