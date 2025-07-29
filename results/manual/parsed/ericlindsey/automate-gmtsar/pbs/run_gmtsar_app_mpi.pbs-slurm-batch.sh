#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ericlindsey/automate-gmtsar/pbs/run_gmtsar_app_mpi.pbs
