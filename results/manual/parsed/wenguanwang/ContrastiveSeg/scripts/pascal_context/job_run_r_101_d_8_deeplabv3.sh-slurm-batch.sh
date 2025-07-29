#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wenguanwang/ContrastiveSeg/scripts/pascal_context/job_run_r_101_d_8_deeplabv3.sh
