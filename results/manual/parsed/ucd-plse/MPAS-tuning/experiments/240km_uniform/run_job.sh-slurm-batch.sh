#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ucd-plse/MPAS-tuning/experiments/240km_uniform/run_job.sh
