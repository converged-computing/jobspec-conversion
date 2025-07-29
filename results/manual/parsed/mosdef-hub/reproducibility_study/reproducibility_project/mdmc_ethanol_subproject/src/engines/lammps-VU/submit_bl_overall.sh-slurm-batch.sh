#!/bin/bash
#SBATCH --job-name=bl_analysis
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12g
#SBATCH --time=8-07:59:59

module purge
module load anaconda
conda --version
source activate mosdef-study38
python bl_analysis_overall.py
