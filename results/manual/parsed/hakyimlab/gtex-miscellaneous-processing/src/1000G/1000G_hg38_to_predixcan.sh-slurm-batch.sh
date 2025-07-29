#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hakyimlab/gtex-miscellaneous-processing/src/1000G/1000G_hg38_to_predixcan.sh
