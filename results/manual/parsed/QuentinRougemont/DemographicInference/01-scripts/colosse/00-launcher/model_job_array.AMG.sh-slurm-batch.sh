#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/QuentinRougemont/DemographicInference/01-scripts/colosse/00-launcher/model_job_array.AMG.sh
