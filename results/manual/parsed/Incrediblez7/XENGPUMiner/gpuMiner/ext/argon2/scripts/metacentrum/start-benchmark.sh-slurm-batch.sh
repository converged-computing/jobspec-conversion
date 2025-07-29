#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Incrediblez7/XENGPUMiner/gpuMiner/ext/argon2/scripts/metacentrum/start-benchmark.sh
