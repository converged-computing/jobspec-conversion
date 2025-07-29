#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UKPLab/tacl2020-interactive-ranking/scripts/PBSPro/run_inter_sum_reaper_2001_lownoise_10.sh
