#!/bin/bash
#SBATCH --job-name=dk_test
#SBATCH --account=m2043
#SBATCH --output=/global/homes/d/danielk/log/%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1,haswell

module load cray-petsc-64
module load cray-hdf5-parallel
input=$SCRATCH/test/solution_input.h5
output=$SCRATCH/solution_output.h5
srun $HOME/BigFeta/bigfeta/distributed/bin/bigfeta_solver_cori \
-input ${input} \
-output ${output} \
-ksp_type preonly -pc_type lu -pc_factor_mat_solver_package superlu_dist \
-log_view
