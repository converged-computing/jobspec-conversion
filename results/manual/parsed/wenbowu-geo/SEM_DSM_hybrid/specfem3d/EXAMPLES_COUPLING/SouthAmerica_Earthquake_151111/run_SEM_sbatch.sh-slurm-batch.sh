#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wenbowu-geo/SEM_DSM_hybrid/specfem3d/EXAMPLES_COUPLING/SouthAmerica_Earthquake_151111/run_SEM_sbatch.sh
