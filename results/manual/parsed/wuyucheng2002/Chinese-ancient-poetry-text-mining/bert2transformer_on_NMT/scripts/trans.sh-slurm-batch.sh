#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wuyucheng2002/Chinese-ancient-poetry-text-mining/bert2transformer_on_NMT/scripts/trans.sh
