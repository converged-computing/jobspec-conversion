#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bonaert/explainable_rl/cluster_scripts/lunar_lander/run_with_teacher_ll_seed_300.pbs
