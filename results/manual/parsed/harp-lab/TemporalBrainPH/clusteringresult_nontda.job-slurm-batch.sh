#!/bin/bash
#SBATCH --job-name=clusteringresult_nontda
#SBATCH --output=clusteringresult_nontda_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4069
#SBATCH --time=04:00:00

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/cluster_calculation_nontda.py
