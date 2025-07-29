#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SafarMirek/bachelor_thesis/karolina/mobilenet_eval_nsga_per_layer.sh
