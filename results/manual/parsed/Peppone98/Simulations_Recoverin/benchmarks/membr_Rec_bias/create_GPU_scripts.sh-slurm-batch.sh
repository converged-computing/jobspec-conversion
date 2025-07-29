#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Peppone98/Simulations_Recoverin/benchmarks/membr_Rec_bias/create_GPU_scripts.sh
