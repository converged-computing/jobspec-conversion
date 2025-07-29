#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SODALITE-EU/application-optimisation/MODAK/examples/input/skyline-extraction-training_job.sh
