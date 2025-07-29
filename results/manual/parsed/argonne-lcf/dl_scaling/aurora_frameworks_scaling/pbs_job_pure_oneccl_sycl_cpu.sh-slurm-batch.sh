#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/argonne-lcf/dl_scaling/aurora_frameworks_scaling/pbs_job_pure_oneccl_sycl_cpu.sh
