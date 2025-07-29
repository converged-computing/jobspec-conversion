#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/atlas-calo-ml/GraphNets4Pions_LLNL/submit_array_nearest.sh
