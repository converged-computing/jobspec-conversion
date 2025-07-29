#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jamtrott/superlu_dist/example_scripts/batch_script_mpi_runit_summit_gcc_cuda10.sh
