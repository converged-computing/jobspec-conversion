#!/bin/bash
#SBATCH --job-name=dfc6452
#SBATCH --output=dfc6452_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4069
#SBATCH --time=16:00:00

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 645 --method bn --start 100 --end 150 --distance y --mds n
