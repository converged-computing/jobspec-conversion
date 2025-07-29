#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/auraoupa/config-nextsim/small_arctic_10km/run_10d_8cores/job_run.sh
