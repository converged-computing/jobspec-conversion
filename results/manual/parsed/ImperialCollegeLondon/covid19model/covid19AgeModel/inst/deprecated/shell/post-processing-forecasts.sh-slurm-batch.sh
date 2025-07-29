#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ImperialCollegeLondon/covid19model/covid19AgeModel/inst/deprecated/shell/post-processing-forecasts.sh
