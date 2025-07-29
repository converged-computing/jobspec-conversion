#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UKPLab/arxiv2018-bayesian-ensembles/batch_scripts/PBSPro/run_ARG_EMNLP19.sh
