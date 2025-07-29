#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/richardslab/dynamic_QTL_COVID19/FasterPipeline/MR_bash.sh
