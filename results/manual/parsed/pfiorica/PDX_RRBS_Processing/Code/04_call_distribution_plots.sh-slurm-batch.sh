#!/bin/bash
#SBATCH --job-name=Distribution_plots
#SBATCH --output=logs_bismark/%x.%j.out
#SBATCH --error=logs_bismark/%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=12:00:00
#SBATCH --qos=general-compute
#SBATCH --constraint=ntasks-per-node=4

module load R/3.5.1
cd /projects/rpci/joyceohm/pnfioric/PDX_RRBS_Processing/Code
Rscript 04_distribution_plots_for_samples.R
