#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/isabella232/azurehpc/apps/convergecfd/run_ccfd_3.0_impi.pbs
