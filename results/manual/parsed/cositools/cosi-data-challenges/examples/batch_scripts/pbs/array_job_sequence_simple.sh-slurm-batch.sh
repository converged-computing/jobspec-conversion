#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/cositools/cosi-data-challenges/examples/batch_scripts/pbs/array_job_sequence_simple.sh
