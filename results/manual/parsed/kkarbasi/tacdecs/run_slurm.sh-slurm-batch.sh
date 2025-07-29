#!/bin/bash
#SBATCH --job-name=KavehJob2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=36

module reset
module load python/2.7
python -m pip install --user --no-cache-dir -r requirements.txt 
python run_parallel.py
