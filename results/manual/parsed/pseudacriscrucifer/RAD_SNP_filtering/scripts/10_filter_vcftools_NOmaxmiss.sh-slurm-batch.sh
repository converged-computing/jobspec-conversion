#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pseudacriscrucifer/RAD_SNP_filtering/scripts/10_filter_vcftools_NOmaxmiss.sh
