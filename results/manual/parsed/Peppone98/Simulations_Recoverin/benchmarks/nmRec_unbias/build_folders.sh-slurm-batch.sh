#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Peppone98/Simulations_Recoverin/benchmarks/nmRec_unbias/build_folders.sh
