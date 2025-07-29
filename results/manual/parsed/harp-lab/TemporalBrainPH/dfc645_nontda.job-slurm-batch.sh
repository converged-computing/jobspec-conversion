#!/bin/bash
#SBATCH --job-name=dfc645_nontda
#SBATCH --output=dfc645_nontda_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4069
#SBATCH --time=10:00:00
#SBATCH --partition=amd-hdr100

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/non_tda_distance_calculation.py --data 645 --method eu --start 1 --end 316 --distance y --mds y
