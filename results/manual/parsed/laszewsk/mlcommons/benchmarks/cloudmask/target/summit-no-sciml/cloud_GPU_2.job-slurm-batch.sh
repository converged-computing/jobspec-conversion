#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/laszewsk/mlcommons/benchmarks/cloudmask/target/summit-no-sciml/cloud_GPU_2.job
