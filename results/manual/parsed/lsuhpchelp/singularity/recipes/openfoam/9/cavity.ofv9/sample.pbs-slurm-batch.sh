#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lsuhpchelp/singularity/recipes/openfoam/9/cavity.ofv9/sample.pbs
