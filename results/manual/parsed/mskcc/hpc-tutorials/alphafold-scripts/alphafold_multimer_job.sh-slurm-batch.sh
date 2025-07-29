#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mskcc/hpc-tutorials/alphafold-scripts/alphafold_multimer_job.sh
