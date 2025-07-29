#!/bin/bash
#SBATCH --job-name=dfc2500
#SBATCH --output=dfc2500_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=4069
#SBATCH --time=04:00:00
#SBATCH --partition=amd-hdr100

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 2500 --method bn --start 1 --end 316 --distance y --mds y
