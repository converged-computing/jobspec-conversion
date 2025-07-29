#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Linwei94/Focal-Loss-Search/hpc_scripts/USYD-HPC-Scripts/search_retrain.sh
