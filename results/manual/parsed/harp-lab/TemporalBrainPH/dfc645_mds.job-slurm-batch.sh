#!/bin/bash
#SBATCH --job-name=dfc645_mds
#SBATCH --output=dfc645_mds_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=4069
#SBATCH --time=08:00:00
#SBATCH --partition=amd-hdr100

set -e
source /home/ashovon/newaumri/matfiles/venv/bin/activate
python -u /home/ashovon/newaumri/matfiles/TemporalBrainPH/distance_calculation.py --data 645 --method bn --start 1 --end 316 --distance n --mds y
