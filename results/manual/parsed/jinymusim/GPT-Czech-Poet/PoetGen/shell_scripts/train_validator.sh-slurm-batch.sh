#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jinymusim/GPT-Czech-Poet/PoetGen/shell_scripts/train_validator.sh
