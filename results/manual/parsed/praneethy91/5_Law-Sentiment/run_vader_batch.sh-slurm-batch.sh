#!/bin/bash
#SBATCH --job-name=paragraph_sentiment
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=nk2239@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=30GB
#SBATCH --time=4-03:00:00

module purge
module load python3/intel/3.5.3
module load nltk/3.2.2
python3 paragraph_sentiment_vader.py
