#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/samanfrm/HER2_prediction/data_cleaning_formatting/run_preprocessing_cpu.sh
