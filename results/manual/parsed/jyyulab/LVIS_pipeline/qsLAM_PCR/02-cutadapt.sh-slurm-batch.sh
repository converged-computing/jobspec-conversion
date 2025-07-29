#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jyyulab/LVIS_pipeline/qsLAM_PCR/02-cutadapt.sh
