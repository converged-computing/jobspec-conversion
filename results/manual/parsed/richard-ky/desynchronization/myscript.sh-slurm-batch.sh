#!/bin/bash
#SBATCH --job-name=desync
#SBATCH --output=desync.txt
#SBATCH --mail-user=richard.ky@sjsu.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=56
#SBATCH --mem=4000
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

module load matlab
matlab -nodisplay -nosplash -nodesktop -r "run('Data_Collection_Desynchronization.m')", exit
