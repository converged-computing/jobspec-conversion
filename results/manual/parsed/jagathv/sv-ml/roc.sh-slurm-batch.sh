#!/bin/bash
#SBATCH --mail-user=jagath@caltech.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60000
#SBATCH --time=4-04:00:00
#SBATCH --partition=general

module load Python
module load matplotlib
python roc_prc_gen.py [input file] [output file] 
