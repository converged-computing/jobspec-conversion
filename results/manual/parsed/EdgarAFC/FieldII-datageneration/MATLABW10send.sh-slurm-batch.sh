#!/bin/bash
#SBATCH --output=log_w10.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --partition=thinkstation-p360
#SBATCH --nodelist=worker10

matlab -nosplash -nodesktop -nodisplay -r "gendata_w10; exit"
