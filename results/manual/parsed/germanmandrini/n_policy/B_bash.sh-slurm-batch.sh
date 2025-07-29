#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

cd /projects/aces
module load singularity ## Load the singularity runtime to your environment
bash_n=151
echo "$cell_n"
singularity exec /projects/aces/germanm2/apsim_nov16.simg Rscript /projects/aces/germanm2/n_policy_git/Codes/simA_manager.R $cell_n $bash_n
