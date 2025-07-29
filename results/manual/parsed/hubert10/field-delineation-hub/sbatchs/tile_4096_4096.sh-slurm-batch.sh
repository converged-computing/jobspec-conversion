#!/bin/bash
#SBATCH --job-name=cpu_job_tile_4096_4096
#SBATCH --output=logs/cpu_job_tile_4096_4096_%j.out
#SBATCH --mail-user=h.kanyamahanga@cgiar.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=500gb
#SBATCH --time=07:00:00

pwd; hostname; date
module load tensorflow/2.4.1
python make_predictions.py
date
