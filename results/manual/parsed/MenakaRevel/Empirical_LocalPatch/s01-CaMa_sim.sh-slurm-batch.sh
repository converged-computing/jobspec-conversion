#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MenakaRevel/Empirical_LocalPatch/s01-CaMa_sim.sh
