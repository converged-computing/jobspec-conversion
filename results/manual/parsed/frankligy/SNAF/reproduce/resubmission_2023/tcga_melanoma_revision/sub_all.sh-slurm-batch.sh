#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/frankligy/SNAF/reproduce/resubmission_2023/tcga_melanoma_revision/sub_all.sh
