#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ShellWee/NASA_GEM_TAITATUMU/module3/Solar_Wind_to_Kp_index/job/train.sh
