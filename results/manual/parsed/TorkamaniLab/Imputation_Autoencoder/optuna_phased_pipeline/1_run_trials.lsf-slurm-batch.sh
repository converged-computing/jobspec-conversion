#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/TorkamaniLab/Imputation_Autoencoder/optuna_phased_pipeline/1_run_trials.lsf
