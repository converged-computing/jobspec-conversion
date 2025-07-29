#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bakajstep/KNN_Project2024/metacetrum_scripts/ner_eval_new.sh
