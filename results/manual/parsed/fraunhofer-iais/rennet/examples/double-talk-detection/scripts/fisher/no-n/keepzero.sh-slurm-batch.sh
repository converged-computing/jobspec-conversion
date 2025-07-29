#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/fraunhofer-iais/rennet/examples/double-talk-detection/scripts/fisher/no-n/keepzero.sh
