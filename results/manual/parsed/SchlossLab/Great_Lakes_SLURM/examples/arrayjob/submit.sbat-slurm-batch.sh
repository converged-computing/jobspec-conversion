#!/bin/bash
#SBATCH --job-name=arr
#SBATCH --account=training
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --array=1-3

matlab -nodisplay -r arr
