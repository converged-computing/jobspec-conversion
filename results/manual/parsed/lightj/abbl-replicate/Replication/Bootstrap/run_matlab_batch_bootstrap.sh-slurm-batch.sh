#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lightj/abbl-replicate/Replication/Bootstrap/run_matlab_batch_bootstrap.sh
