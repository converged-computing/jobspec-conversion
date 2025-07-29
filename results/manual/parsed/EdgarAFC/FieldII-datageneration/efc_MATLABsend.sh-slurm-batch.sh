#!/bin/bash
#SBATCH --output=log_get_h5.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=thinkstation-p360
#SBATCH --nodelist=worker9

srun matlab -nosplash -nodesktop -nodisplay -r "getting_h5; exit"
