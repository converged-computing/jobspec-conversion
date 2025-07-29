#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/aponsero/ML_Feature_Extraction_TRAINING/scripts/run_kmercouter_array.sh
