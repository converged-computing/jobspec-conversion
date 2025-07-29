#!/bin/bash
#SBATCH --job-name=param_codes
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/grqa_processing
module purge
module load python
source activate river_quality
~/.conda/envs/river_quality/bin/python param_codes.py
