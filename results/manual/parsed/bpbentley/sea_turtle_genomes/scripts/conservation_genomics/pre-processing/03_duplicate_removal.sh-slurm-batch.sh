#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bpbentley/sea_turtle_genomes/scripts/conservation_genomics/pre-processing/03_duplicate_removal.sh
