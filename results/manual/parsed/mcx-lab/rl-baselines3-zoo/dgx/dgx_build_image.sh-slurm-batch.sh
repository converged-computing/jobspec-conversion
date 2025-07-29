#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mcx-lab/rl-baselines3-zoo/dgx/dgx_build_image.sh
