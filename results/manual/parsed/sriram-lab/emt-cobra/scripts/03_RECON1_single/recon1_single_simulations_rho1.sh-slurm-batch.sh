#!/bin/bash
#SBATCH --job-name=recon1_emt_a549_1
#SBATCH --account=lsa1
#SBATCH --output=./recon1_rho1_output.log
#SBATCH --error=./recon1_rho1_error.err
#SBATCH --mail-user=scampit@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4g
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=8

module load matlab/R2020a
module load gurobi
matlab -nodisplay -r "run('/home/scampit/Turbo/scampit/Software/emt/srv/recon1_scCOBRA_rho1.m'); exit"
