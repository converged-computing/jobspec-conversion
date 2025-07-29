#!/bin/bash
#SBATCH --job-name=DQN
#SBATCH --output=slurm_logs/DQN.out
#SBATCH --error=slurm_logs/DQN.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

./run_exp.sh test 5000
