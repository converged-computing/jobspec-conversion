#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WeberLab/PrecisionHealthVirtualEnvironment/Workshops/scRNAseq/run_rstudio.sh
