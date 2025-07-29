#!/bin/bash
#SBATCH --job-name=randomcluster_2
#SBATCH --output=randomcluster_2_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4069
#SBATCH --time=10:00:00
#SBATCH --partition=amd-hdr100

set -e
source /home/ashovon/venvs/brainph/bin/activate
python -u /home/ashovon/brainPH/cluster_calculation_random.py
