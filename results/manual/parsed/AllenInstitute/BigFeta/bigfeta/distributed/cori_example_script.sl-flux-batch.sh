#!/bin/bash
#FLUX: --job-name=butterscotch-sundae-6335
#FLUX: --urgency=16

module load cray-petsc-64
module load cray-hdf5-parallel
input=$SCRATCH/test/solution_input.h5
output=$SCRATCH/solution_output.h5
srun $HOME/BigFeta/bigfeta/distributed/bin/bigfeta_solver_cori \
-input ${input} \
-output ${output} \
-ksp_type preonly -pc_type lu -pc_factor_mat_solver_package superlu_dist \
-log_view
