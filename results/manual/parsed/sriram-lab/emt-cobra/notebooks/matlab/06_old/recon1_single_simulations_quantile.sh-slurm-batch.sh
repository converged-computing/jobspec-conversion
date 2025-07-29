#!/bin/bash
#SBATCH --job-name=recon1_emt_a549_quantile
#SBATCH --account=lsa1
#SBATCH --output=./recon1_quantile_output.log
#SBATCH --error=./recon1_quantile_error.err
#SBATCH --mail-user=scampit@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4g
#SBATCH --time=1-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --licenses=gurobi@slurmdb:8

module load matlab/R2018b
module load gurobi/9.1.1
matlab -nodisplay -r "run('/home/scampit/Turbo/scampit/Software/emt-cobra/notebooks/matlab/06_old/quantile_cobra_simulations.m'); exit"
