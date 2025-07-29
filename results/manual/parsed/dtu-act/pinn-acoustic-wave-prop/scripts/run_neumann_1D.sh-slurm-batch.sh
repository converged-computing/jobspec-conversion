#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dtu-act/pinn-acoustic-wave-prop/scripts/run_neumann_1D.sh
