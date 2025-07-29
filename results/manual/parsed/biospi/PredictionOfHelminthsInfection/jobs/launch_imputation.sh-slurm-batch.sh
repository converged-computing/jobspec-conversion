#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/biospi/PredictionOfHelminthsInfection/jobs/launch_imputation.sh
