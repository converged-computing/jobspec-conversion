#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/HuffordLab/NAM-genomes/methylation/scripts/UMR_algorithm_all_contexts_v1.3.NAM_founders.sh
