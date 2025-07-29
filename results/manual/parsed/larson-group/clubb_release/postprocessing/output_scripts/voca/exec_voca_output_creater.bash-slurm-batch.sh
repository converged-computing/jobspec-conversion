#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/larson-group/clubb_release/postprocessing/output_scripts/voca/exec_voca_output_creater.bash
