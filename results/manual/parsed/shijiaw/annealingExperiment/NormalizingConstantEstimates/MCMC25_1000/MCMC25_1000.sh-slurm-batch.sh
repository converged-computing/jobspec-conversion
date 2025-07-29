#!/bin/bash
#SBATCH --account=def-liang-ab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00

module load r/3.4.0
module load java/1.8.0_121
nextflow run  MCMC25_1000.nf -resume
