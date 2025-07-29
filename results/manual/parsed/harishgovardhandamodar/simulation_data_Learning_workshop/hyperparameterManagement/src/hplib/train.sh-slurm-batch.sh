#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/harishgovardhandamodar/simulation_data_Learning_workshop/hyperparameterManagement/src/hplib/train.sh
