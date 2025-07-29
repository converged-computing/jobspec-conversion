#!/bin/bash
#SBATCH --account=5-33262
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=250G
#SBATCH --time=2-00:00:00

spack env activate nick
Rscript ./scripts/Analyses_Mallard_MultistateModel.R
