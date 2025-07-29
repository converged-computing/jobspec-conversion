#!/bin/bash
#SBATCH --mail-user=your@email.aaa
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=96
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

export PETSC_DIR='/scratch/gpfs/ethier/STELLAR/Software/INTEL_MPI_2021'
export LD_LIBRARY_PATH='${PETSC_DIR}/lib:${LD_LIBRARY_PATH}'

module load intel/2021.1.2
module load intel-mpi/intel/2021.3.1
export PETSC_DIR=/scratch/gpfs/ethier/STELLAR/Software/INTEL_MPI_2021
export LD_LIBRARY_PATH=${PETSC_DIR}/lib:${LD_LIBRARY_PATH}
srun -n 96 ./edipic2d >& output.log
