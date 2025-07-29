#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/excess-project/starpu-energy-aware-extension/examples/sgemm_history/pbs.sh
