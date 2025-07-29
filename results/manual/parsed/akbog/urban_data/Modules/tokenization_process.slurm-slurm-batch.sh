#!/bin/bash
#SBATCH --output=tokenjob.o
#SBATCH --error=tokenjob.e
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=1-00:00:00

module purge
module load anaconda3/5.2.0
source ../../../Scripts/venv-urban/bin/activate
python3 tokenizing_dask.py
