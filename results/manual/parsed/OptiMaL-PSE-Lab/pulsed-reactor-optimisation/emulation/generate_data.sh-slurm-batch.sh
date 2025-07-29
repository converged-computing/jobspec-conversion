#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/OptiMaL-PSE-Lab/pulsed-reactor-optimisation/emulation/generate_data.sh
