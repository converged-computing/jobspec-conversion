#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/haniffalab/FCA_fetal_skin/analysis/visium/02.c2l/02.run.predict.cell.abundancies.sh
