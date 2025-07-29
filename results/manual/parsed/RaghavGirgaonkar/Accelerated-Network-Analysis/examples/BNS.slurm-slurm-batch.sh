#!/bin/bash
#SBATCH --job-name=BNS
#SBATCH --output=/path/bns.o%j
#SBATCH --error=/path/bns.e%j
#SBATCH --mail-user=email@utrgv.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

module load matlab
matlab -batch  "addpath($SDMBIGDAT19/CODES); rungwpso_bns allparamfiles.json"
