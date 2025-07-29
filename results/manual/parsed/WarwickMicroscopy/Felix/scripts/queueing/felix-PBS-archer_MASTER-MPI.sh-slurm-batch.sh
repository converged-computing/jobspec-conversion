#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WarwickMicroscopy/Felix/scripts/queueing/felix-PBS-archer_MASTER-MPI.sh
