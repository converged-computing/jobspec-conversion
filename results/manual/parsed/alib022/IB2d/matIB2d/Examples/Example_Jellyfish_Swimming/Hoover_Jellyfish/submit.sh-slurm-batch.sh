#!/bin/bash
#SBATCH --job-name=matlab
#SBATCH --output=job.%j.out
#SBATCH --mail-user=battistn@tcnj.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00
#SBATCH --partition=nolimit
#SBATCH --chdir=./
#SBATCH --nodelist=node006

echo "Starting @ "`date`
matlab -nodisplay < main2d.m > main2d.out
echo "Completed @ "`date`
