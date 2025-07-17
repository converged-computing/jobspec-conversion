#!/bin/bash
#FLUX: --job-name=CPparameter_test
#FLUX: -c=32
#FLUX: --queue=test
#FLUX: -t=900
#FLUX: --urgency=16

export PETSC_DIR='/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib'
export PETSC_FC_INCLUDES='/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/include'
export LD_LIBRARY_PATH='/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib:$LD_LIBRARY_PATH'
export PATH='/projappl/project_2004956/damask-3.0.0-alpha7/grid_solver/bin:$PATH'
export DAMASK_ROOT='/projappl/project_2004956/damask-3.0.0-alpha7'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export materialVTI='$(ls *.vti)'

module load gcc/11.2.0
module load openmpi/4.1.2
module load hdf5
module load fftw
export PETSC_DIR=/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib
export PETSC_FC_INCLUDES=/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/include
export LD_LIBRARY_PATH=/projappl/project_2004956/spack/install_tree/gcc-11.2.0/petsc-3.16.1-zeqfqr/lib:$LD_LIBRARY_PATH
export PATH=/projappl/project_2004956/damask-3.0.0-alpha7/grid_solver/bin:$PATH
export DAMASK_ROOT=/projappl/project_2004956/damask-3.0.0-alpha7
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
ulimit -s unlimited
cd $PWD
export materialVTI=$(ls *.vti)
srun -n 8 DAMASK_grid --load tensionX.yaml --geom $materialVTI
