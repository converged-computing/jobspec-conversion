#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/noiseux1523/Deep-Belief-Network/replication-package-dbn/run_job_DBN.sh
