#!/bin/bash
#SBATCH --account=dp004
#SBATCH --output=standard_output_file.acc.out
#SBATCH --error=standard_error_file.acc.err
#SBATCH --mail-user=lilia.correamagnus@postgrad.manchester.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --partition=cosma8

module purge
module load python/3.10.12
python3 accretion.py
