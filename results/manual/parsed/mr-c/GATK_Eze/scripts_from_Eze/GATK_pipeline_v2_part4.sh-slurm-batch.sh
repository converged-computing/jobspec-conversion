#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mr-c/GATK_Eze/scripts_from_Eze/GATK_pipeline_v2_part4.sh
