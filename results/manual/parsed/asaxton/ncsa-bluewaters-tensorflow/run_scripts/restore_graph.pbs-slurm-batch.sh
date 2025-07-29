#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/asaxton/ncsa-bluewaters-tensorflow/run_scripts/restore_graph.pbs
