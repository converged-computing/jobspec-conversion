#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wecacuee/openai-baselines/pbs/fwrl-her-train-path-rewards-low-thresh-alt.sh
