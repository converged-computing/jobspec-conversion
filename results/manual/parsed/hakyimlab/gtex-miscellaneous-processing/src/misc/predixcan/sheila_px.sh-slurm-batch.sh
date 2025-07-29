#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hakyimlab/gtex-miscellaneous-processing/src/misc/predixcan/sheila_px.sh
