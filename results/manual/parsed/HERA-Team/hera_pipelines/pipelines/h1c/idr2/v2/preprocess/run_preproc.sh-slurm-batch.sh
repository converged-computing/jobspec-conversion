#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/HERA-Team/hera_pipelines/pipelines/h1c/idr2/v2/preprocess/run_preproc.sh
