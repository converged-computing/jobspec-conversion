#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UKPLab/tacl2018-preference-convincing/batch_scripts/TACL2018/run_al.sh
