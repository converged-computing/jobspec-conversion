#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/edwinrobots/BayesianOpt_uncertaiNLP2024/cQA/scripts/interactive_hyper/cooking-parallel.sh
