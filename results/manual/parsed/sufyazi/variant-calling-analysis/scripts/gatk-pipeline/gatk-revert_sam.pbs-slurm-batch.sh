#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sufyazi/variant-calling-analysis/scripts/gatk-pipeline/gatk-revert_sam.pbs
