#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/samirdarouich/MDSetup/templates/bash/build_system_gmx_pbs.sh
