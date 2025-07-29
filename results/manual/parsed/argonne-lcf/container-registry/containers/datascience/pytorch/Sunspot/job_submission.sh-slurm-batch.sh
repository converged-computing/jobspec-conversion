#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/argonne-lcf/container-registry/containers/datascience/pytorch/Sunspot/job_submission.sh
