#!/bin/bash
#SBATCH --job-name=gmx_mpi_test
#SBATCH --account=myproject
#SBATCH --output=gmx_mpi_test.%j.out
#SBATCH --error=gmx_mpi_test.%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=96
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=skx

module load intel/24.0
module load impi/21.11
module load gromacs/2023.3
ibrun gmx_mpi pdb2gmx -f 1AKI_clean.pdb -o 1AKI_processed.gro -water spce -ff oplsaa
