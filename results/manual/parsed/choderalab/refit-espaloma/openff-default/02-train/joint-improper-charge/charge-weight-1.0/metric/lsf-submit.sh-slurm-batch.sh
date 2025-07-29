#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/refit-espaloma/openff-default/02-train/joint-improper-charge/charge-weight-1.0/metric/lsf-submit.sh
