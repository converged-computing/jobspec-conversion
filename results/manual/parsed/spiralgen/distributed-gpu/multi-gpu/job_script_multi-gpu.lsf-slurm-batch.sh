#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/spiralgen/distributed-gpu/multi-gpu/job_script_multi-gpu.lsf
