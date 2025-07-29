#!/bin/bash
#SBATCH --job-name=sample
#SBATCH --output=/path/sample.o%j
#SBATCH --error=/path/sample.e%j
#SBATCH --mail-user=username@utrgv.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); cd /working_dir; rungwpso  /path/to/jsonfiles/allparamfiles.json"
