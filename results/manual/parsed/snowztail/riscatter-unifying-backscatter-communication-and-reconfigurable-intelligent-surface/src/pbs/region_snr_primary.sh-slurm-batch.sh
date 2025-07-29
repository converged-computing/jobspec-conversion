#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/snowztail/riscatter-unifying-backscatter-communication-and-reconfigurable-intelligent-surface/src/pbs/region_snr_primary.sh
