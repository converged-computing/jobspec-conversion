#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Sydney-Informatics-Hub/Somatic-shortV-nf/run_pipeline_on_gadi_script.sh
