#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WarwickMicroscopy/Felix/docs/felix-PBS-testingsuite-MPI.sh
