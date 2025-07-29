#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/BioinfoMachineLearning/GCPNet/scripts/grid_search_template_launcher_script.bash
