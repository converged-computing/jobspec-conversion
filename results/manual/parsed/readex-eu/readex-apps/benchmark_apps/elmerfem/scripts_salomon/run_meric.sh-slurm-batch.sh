#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/readex-eu/readex-apps/benchmark_apps/elmerfem/scripts_salomon/run_meric.sh
