#!/bin/bash
#SBATCH --job-name=matrix-completion-many
#SBATCH --account=mikalst
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=00:10:00

module load intel/2018b
module load Python/3.6.6
module list
matlab -nodisplay -nodesktop -nosplash -nojvm -r "test"
