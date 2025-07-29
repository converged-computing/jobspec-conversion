#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/firedrakeproject/firedrake-fluids/tools/parallel_scaling/src/submit_archer.pbs
