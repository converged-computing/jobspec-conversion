#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Leirof/M2-Unveiling-3D-structure-of-pre-stellar-cores/src/jupyter-tesla.sh
