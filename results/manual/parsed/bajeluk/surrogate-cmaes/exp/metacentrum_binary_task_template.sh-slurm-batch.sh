#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bajeluk/surrogate-cmaes/exp/metacentrum_binary_task_template.sh
