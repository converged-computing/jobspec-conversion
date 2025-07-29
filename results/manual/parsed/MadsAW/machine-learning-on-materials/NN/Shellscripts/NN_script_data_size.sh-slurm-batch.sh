#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MadsAW/machine-learning-on-materials/NN/Shellscripts/NN_script_data_size.sh
