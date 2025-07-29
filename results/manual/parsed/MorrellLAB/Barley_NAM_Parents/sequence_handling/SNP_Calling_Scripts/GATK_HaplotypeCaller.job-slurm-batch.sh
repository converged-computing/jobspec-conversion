#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MorrellLAB/Barley_NAM_Parents/sequence_handling/SNP_Calling_Scripts/GATK_HaplotypeCaller.job
