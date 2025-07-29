#!/bin/bash
#SBATCH --job-name=HT_QOptica_1e3
#SBATCH --output=my.stdout
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=5-00:00:00

date
module load matlab/r2018a
matlab -nodisplay -nosplash <ssfres_normal_thermal_resonance_shift_trans_adapt_04_QingOptica_1e3.m> run.log
