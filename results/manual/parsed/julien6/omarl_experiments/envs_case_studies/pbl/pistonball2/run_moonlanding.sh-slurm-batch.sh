#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/julien6/omarl_experiments/envs_case_studies/pbl/pistonball2/run_moonlanding.sh
