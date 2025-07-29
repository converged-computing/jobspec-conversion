#!/bin/bash
#SBATCH --job-name=cpu_job_predictions_koutiala
#SBATCH --output=cpu_job_predictions_koutiala_%j.out
#SBATCH --mail-user=h.kanyamahanga@cgiar.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=700gb
#SBATCH --time=07:00:00

pwd; hostname; date
module load tensorflow/2.4.1
python field_delineation_end2end.py
date
