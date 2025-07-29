#!/bin/bash
#SBATCH --job-name=Citizenly-RL-SnowPlowing
#SBATCH --account=citizenly
#SBATCH --output=out-04-06-20-1600.o
#SBATCH --error=err-04-06-20-1600.o
#SBATCH --mail-user=mf3791@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:p4:1
#SBATCH --mem=20G
#SBATCH --time=12:00:00
#SBATCH --partition=tier3

spack env activate ml-geo-20070801
echo " (${HOSTNAME}) Job Running..."
python3 trainer.py --task=vrp --nodes=50
echo " *(${HOSTNAME}) Job completed. "
