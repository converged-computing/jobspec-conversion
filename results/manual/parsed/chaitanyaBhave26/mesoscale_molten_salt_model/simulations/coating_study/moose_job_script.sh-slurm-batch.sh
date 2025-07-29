#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/chaitanyaBhave26/mesoscale_molten_salt_model/simulations/coating_study/moose_job_script.sh
