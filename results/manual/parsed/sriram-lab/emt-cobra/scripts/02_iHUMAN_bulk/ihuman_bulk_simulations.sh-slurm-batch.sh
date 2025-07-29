#!/bin/bash
#SBATCH --job-name=ihuman_emt_a549_1
#SBATCH --account=lsa1
#SBATCH --output=./ihuman_bulk_output.log
#SBATCH --error=./ihuman_bulk_error.err
#SBATCH --mail-user=scampit@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=1g
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=1

module load matlab/R2020a
module load gurobi
matlab -nodisplay -r "run('/home/scampit/Turbo/scampit/Software/emt/srv/ihuman_simulations.m'); exit"
