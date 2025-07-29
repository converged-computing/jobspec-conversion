#!/bin/bash
#SBATCH --job-name=xarray
#SBATCH --account=your_account
#SBATCH --output=xarray_%j.out
#SBATCH --error=xarray_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=20:00:00

cd /path/to/your/scratch/folder
module purge
module load anaconda-py3/2021.05
conda activate /path/to/conda/environment
echo `which python`
python example.py
