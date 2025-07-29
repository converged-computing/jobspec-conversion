#!/bin/bash
#SBATCH --job-name=mapsim
#SBATCH --output=mapsim_%j.out
#SBATCH --error=mapsim_%J.err
#SBATCH --mail-user=scottgbarnes@gwu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=debug-cpu
#SBATCH --chdir=/home/scottgbarnes/Cooperative-Search-Gym

module load anaconda
source activate tensorflow
python run_mapEnv.py
