#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MRCIEU/PHESANT-MR-pheWAS-smoking/3-follow-up/a-make-dataset/a-retrieve-snps/j-retrieve-snps.sh
