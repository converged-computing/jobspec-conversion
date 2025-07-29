#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/HERA-Team/hera-validation/test-series/4/tools/prepare_abscal_model_files.pbs
