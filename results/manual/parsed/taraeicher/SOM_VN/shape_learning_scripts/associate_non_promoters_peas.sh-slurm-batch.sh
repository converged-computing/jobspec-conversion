#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/taraeicher/SOM_VN/shape_learning_scripts/associate_non_promoters_peas.sh
