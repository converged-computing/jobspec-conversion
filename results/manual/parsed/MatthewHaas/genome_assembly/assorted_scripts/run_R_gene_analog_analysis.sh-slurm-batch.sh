#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MatthewHaas/genome_assembly/assorted_scripts/run_R_gene_analog_analysis.sh
