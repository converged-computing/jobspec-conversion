#!/bin/bash
#SBATCH --job-name=abcd
#SBATCH --output=True
#SBATCH --error=True
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --partition=lab_fat_c

module purge
module load MATLAB/R2018b
test
matlab -nodesktop -nosplash -r "sub_n=$1;Step_one_site16_code_par.m;quit"
