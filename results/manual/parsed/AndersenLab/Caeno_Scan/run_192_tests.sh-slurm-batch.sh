#!/bin/bash
#SBATCH --job-name=run_test_sims
#SBATCH --account=b1042
#SBATCH --output=repeated_test_output.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1

module load singularity
nextflow run multi_species_simfiles.nf
