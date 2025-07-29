#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/erdc/proteus/proteus/tests/test_mpi4py_petsc4py_diamond.pbs
