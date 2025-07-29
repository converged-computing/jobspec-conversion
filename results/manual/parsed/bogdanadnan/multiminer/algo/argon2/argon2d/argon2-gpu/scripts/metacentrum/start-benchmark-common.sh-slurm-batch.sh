#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bogdanadnan/multiminer/algo/argon2/argon2d/argon2-gpu/scripts/metacentrum/start-benchmark-common.sh
