#!/bin/bash
#SBATCH --job-name=dfc1400
#SBATCH --output=dfc1400_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4069
#SBATCH --time=05:00:00

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 1400 --method ws --start 1 --end 316 --distance y --mds y
