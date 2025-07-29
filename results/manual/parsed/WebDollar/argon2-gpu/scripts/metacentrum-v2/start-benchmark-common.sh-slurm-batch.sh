#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WebDollar/argon2-gpu/scripts/metacentrum-v2/start-benchmark-common.sh
