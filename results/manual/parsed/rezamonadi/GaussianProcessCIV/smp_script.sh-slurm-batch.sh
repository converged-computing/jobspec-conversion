#!/bin/bash
#SBATCH --job-name=parSampling
#SBATCH --output=parSampling.out
#SBATCH --mail-user=rmona003@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=128gb
#SBATCH --time=10:00:00
#SBATCH --partition=intel

module load matlab
matlab -nodesktop -nosplash -r "parpool('local', 32); WSamplePar;"
echo "----"
hostname
