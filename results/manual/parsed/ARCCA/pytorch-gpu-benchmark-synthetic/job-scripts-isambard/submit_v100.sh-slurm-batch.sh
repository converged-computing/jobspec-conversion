#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ARCCA/pytorch-gpu-benchmark-synthetic/job-scripts-isambard/submit_v100.sh
