#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CampagneLaboratory/goby/scripts/pbs/setup-pbs-align-job.sh
