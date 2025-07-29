#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pinellolab/scATAC-benchmarking/Real_Data/10x_PBMC_5k/run_methods/BROCKMAN/Brockman-master/Example/example_run_pipeine_LSF.sh
