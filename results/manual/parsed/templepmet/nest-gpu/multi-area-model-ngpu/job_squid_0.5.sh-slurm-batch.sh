#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/templepmet/nest-gpu/multi-area-model-ngpu/job_squid_0.5.sh
