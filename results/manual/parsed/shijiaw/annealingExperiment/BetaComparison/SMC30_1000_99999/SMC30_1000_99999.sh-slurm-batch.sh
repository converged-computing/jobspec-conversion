#!/bin/bash
#SBATCH --account=def-liang-ab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:15

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC30_1000_99999.nf -resume
