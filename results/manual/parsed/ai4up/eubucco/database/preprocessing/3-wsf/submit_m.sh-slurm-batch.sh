#!/bin/bash
#SBATCH --job-name=wsf-%A_%a
#SBATCH --account=eubucco
#SBATCH --output=wsf_out-%A_%a.txt
#SBATCH --error=wsf_err-%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:03:00
#SBATCH --qos=short
#SBATCH --chdir=/p/tmp/nikolami/wsf

pwd; hostname; date
module load anaconda
source activate /home/nikolami/.conda/envs/ox112
python -u /p/projects/eubucco/git-eubucco/database/preprocessing/3-wsf/creating-wsf-evo-matching.py
