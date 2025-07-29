#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hesselberthlab/5OH/src/old_code/pipeline/0_humanmaster.sh
