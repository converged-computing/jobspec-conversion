#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/PacificBiosciences/pb-human-wgs-workflow-snakemake/process_cohort.lsf.sh
