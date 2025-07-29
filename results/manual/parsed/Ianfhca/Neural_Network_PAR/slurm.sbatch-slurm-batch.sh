#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=outputs/M_%A.out
#SBATCH --error=outputs/M_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --partition=EHP-PAR
#SBATCH --array=1-1

