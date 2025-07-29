#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AkirisMc/thesis-FL16-pipeline/s03_analysis_callahan/s02_analysis_HMP_FL16S.sh
