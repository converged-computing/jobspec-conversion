#!/bin/bash
#SBATCH --job-name=MPI_JOB
#SBATCH --account=nesi00119
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=00:59:00
#SBATCH --constraint=sb

export LD_LIBRARY_PATH='/projects/nesi00119/code/JWR_petsc/petsc-3.5.4/linux-intel/lib:$LD_LIBRARY_PATH'

echo $HOSTNAME
module load intel/2015a
module load Python/2.7.9-intel-2015a
export LD_LIBRARY_PATH=/projects/nesi00119/code/JWR_petsc/petsc-3.5.4/linux-intel/lib:$LD_LIBRARY_PATH
srun -o sim.log ./src/cell_3d
