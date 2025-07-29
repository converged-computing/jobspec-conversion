#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AlexanderKroll/ESP/data/enzyme_data/hyperparamter_FCNN_full_KM.sh
