#!/bin/bash
#SBATCH --job-name=compare_methylation_change_plots
#SBATCH --output=logs_bismark/%x.%j.out
#SBATCH --error=logs_bismark/%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=1-00:00:00
#SBATCH --qos=general-compute
#SBATCH --constraint=ntasks-per-node=4

module load R/3.5.1
cd /projects/rpci/joyceohm/pnfioric/PDX_RRBS_Processing/Code
Rscript 06_Compare_Methylation_Change.R
