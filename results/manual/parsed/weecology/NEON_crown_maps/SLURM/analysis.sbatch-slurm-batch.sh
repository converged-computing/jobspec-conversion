#!/bin/bash
#SBATCH --job-name=DeepForest
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/analysis_%j.out
#SBATCH --error=/home/b.weinstein/logs/analysis_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=3-00:00:00

source activate crowns
cd /home/b.weinstein/NEON_crown_maps/analysis/
python dask_analysis.py
