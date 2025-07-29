#!/bin/bash
#SBATCH --job-name=compare_methylation_Density_plots
#SBATCH --output=logs_bismark/%x.%j.out
#SBATCH --error=logs_bismark/%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=12:00:00
#SBATCH --partition=general-compute
#SBATCH --qos=general-compute
#SBATCH --constraint=ntasks-per-node=4

module load R/3.5.1
cd /projects/rpci/joyceohm/pnfioric/PDX_RRBS_Processing/Code
Rscript 05_Compare_Methylation_Density.R
