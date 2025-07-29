#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UKPLab/tacl2020-interactive-ranking/scripts/PBSPro/run_inter_sum_supert_2004.sh
