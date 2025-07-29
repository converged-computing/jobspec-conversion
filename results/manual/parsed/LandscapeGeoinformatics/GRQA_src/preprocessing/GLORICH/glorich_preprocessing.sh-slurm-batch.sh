#!/bin/bash
#SBATCH --job-name=glorich_preprocessing
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

ds_name="GLORICH"
cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/preprocessing/${ds_name}
module purge
module load python
source activate river_quality
~/.conda/envs/river_quality/bin/python glorich_preprocessing.py
