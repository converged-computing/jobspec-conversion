#!/bin/bash
#SBATCH --job-name=hddm_fitting
#SBATCH --account=carney-frankmj-condo
#SBATCH --output=/users/tsumme/batch_job_out/hddm_fitting_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=64G
#SBATCH --time=18:00:00
#SBATCH --array=1-1

python -u /users/tsumme/fit_hddm.py $1 $2 $3 $4
