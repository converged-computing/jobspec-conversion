#!/bin/bash
#SBATCH --job-name=CPparameter_test
#SBATCH --account=project_2004956
#SBATCH --error=CPparameter_test
#SBATCH --mail-user=rongfei.juan@aalto.fi
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=01:00:00
#SBATCH --partition=medium
#SBATCH --constraint=ntasks-per-node=8

export PETSC_DIR='/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib'
export PETSC_FC_INCLUDES='/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/include'
export LD_LIBRARY_PATH='/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib:$LD_LIBRARY_PATH'
export PATH='/projappl/project_2004956/damask3/grid_solver/bin:$PATH'
export DAMASK_ROOT='/projappl/project_2004956/damask3/damask-3.0.0-alpha6'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load gcc/11.2.0
module load openmpi/4.1.2
module load hdf5
module load fftw
export PETSC_DIR=/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib
export PETSC_FC_INCLUDES=/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/include
export LD_LIBRARY_PATH=/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib:$LD_LIBRARY_PATH
export PATH=/projappl/project_2004956/damask3/grid_solver/bin:$PATH
export DAMASK_ROOT=/projappl/project_2004956/damask3/damask-3.0.0-alpha6
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
ulimit -s unlimited
cd $PWD
srun -n 8 DAMASK_grid --load tensionX.yaml --geom QPRVE50.vti
