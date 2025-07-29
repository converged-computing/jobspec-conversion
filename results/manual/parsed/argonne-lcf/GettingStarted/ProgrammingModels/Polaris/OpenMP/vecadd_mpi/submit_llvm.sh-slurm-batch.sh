#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/argonne-lcf/GettingStarted/ProgrammingModels/Polaris/OpenMP/vecadd_mpi/submit_llvm.sh
