#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pentschev/nvrapids_olcf/gtc_2020/cudf/job_scripts/launch_pandas.lsf
