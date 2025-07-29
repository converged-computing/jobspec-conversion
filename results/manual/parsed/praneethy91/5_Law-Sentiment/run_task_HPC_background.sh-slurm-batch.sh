#!/bin/bash
#SBATCH --job-name=paragraph_sentiment
#SBATCH --output=abc.out
#SBATCH --mail-user=bsg348@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=70GB
#SBATCH --time=06:00:00

module purge
module load python3/intel/3.5.3
python3 get_ckt_yr_from_case.py
