#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/chameleon-hpc/samoa-chameleon/scripts/claix/samoa_chameleon_run_batch_clx16_insp.sh
