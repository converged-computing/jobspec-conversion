#!/bin/bash
#SBATCH --job-name=test_detection
#SBATCH --output=test.output
#SBATCH --error=error.output
#SBATCH --mail-user=bxu2522@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=90000
#SBATCH --time=16:40:00
#SBATCH --partition=work
#SBATCH --constraint=ntasks-per-node=12

module load matlab
matlab -nodisplay -nosplash -nodesktop < MonteCarloRun_33.m
