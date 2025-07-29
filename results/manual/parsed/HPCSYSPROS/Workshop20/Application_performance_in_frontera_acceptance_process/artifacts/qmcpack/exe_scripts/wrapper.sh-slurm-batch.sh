#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/HPCSYSPROS/Workshop20/Application_performance_in_frontera_acceptance_process/artifacts/qmcpack/exe_scripts/wrapper.sh
