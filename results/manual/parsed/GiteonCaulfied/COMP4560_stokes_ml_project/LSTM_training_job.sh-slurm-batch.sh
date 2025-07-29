#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GiteonCaulfied/COMP4560_stokes_ml_project/LSTM_training_job.sh
