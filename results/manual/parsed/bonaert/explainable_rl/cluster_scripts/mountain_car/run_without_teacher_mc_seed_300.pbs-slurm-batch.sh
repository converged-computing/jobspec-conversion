#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bonaert/explainable_rl/cluster_scripts/mountain_car/run_without_teacher_mc_seed_300.pbs
