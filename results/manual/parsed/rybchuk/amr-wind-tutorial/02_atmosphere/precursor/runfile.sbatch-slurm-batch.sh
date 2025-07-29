#!/bin/bash
#SBATCH --account=awaken
#SBATCH --output=logs/job_output_filename.%j.out
#SBATCH --mail-user=XX@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:59:00

export EXAWIND_DIR='/nopt/nrel/ecom/exawind/exawind-2020-09-21/install/gcc'
export MPI_TYPE_DEPTH='15'
export MPI_IB_CONGESTED='true'
export MPI_XPMEM_ENABLED='disabled'

module purge
module load gcc/8.4.0 mpt mkl cmake
export EXAWIND_DIR=/nopt/nrel/ecom/exawind/exawind-2020-09-21/install/gcc
export MPI_TYPE_DEPTH=15
export MPI_IB_CONGESTED=true
export MPI_XPMEM_ENABLED=disabled
cd /scratch/orybchuk/wakedynamics/amr-wind-tutorial/02_atmosphere/precursor
rm -rf post_processing
ln -sf /projects/awaken/orybchuk/spack-june22/amr-wind/spack-build-4ixvlaf/amr_wind .
srun -n 72 -c 1 --cpu_bind=cores amr_wind precursor.i
