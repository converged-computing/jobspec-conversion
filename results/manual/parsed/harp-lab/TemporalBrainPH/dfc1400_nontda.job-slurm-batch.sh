#!/bin/bash
#SBATCH --job-name=dfc1400_nontda
#SBATCH --output=dfc1400_nontda_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4069
#SBATCH --time=05:00:00
#SBATCH --partition=amd-hdr100

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/non_tda_distance_calculation.py --data 1400 --method eu --start 1 --end 316 --distance y --mds y
