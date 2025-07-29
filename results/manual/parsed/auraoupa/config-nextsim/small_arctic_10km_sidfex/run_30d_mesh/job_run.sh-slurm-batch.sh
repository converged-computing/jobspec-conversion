#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/auraoupa/config-nextsim/small_arctic_10km_sidfex/run_30d_mesh/job_run.sh
