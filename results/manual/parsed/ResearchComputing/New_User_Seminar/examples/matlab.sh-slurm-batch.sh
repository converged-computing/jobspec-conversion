#!/bin/bash
#SBATCH --output=matlab_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00
#SBATCH --qos=testing

module purge
module load matlab/R2019b
matlab -nodisplay -nodesktop -r "clear; matlab_tic;"
echo
echo "Job done."
