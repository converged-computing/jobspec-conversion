#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dthorburn/RNAseq_Workflows/STAR_2Pass/STAR_Align.sh
