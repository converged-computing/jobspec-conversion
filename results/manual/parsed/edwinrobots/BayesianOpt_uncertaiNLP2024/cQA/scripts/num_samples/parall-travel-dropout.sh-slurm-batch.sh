#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/edwinrobots/BayesianOpt_uncertaiNLP2024/cQA/scripts/num_samples/parall-travel-dropout.sh
