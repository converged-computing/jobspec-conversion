#!/bin/bash
#SBATCH --job-name=GMMreg_7
#SBATCH --account=axs
#SBATCH --output=nrun.out
#SBATCH --error=nrun.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=8gb
#SBATCH --time=11:00:00

module load matlab/2018b
matlab -nosplash -nodisplay -nodesktop -r GMMreg_toCommonCoords
