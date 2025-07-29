#!/bin/bash
#SBATCH --job-name=run_simfiles
#SBATCH --account=b1042
#SBATCH --output=20230824_sim_files_0.01.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

module load singularity
nextflow run prepare_sims.nf --ld true --out 20230824_sim_files_ld_0.01 
