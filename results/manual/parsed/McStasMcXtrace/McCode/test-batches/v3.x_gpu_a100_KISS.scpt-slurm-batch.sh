#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/McStasMcXtrace/McCode/test-batches/v3.x_gpu_a100_KISS.scpt
