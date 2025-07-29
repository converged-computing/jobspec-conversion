#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=15:00:00

srun ./run_mainNSF_1.sh /appl/math/matlab/R2014a
