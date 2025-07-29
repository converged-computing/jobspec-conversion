#!/bin/bash
#SBATCH --job-name=dfc645
#SBATCH --output=dfc645_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=4069
#SBATCH --time=14:00:00

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 645 --method ws --start 1 --end 316 --distance y --mds y
