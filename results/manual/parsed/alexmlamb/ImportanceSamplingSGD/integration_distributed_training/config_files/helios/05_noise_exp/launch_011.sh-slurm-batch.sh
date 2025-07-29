#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/alexmlamb/ImportanceSamplingSGD/integration_distributed_training/config_files/helios/05_noise_exp/launch_011.sh
