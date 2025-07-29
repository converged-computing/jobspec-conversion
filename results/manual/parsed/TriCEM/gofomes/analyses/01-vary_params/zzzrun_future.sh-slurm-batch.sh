#!/bin/bash
#SBATCH --job-name=fomes_sim_varyparams
#SBATCH --output=fomes_varyparams_%j.log
#SBATCH --mail-user=nbrazeau@med.unc.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=128G
#SBATCH --time=5-00:00:00

R CMD BATCH 01-run_fomes_on_maestro.R
