#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hpc-uk/archer-benchmarks/apps/GROMACS/1400k-atoms/profiles/run/gromacs_cirrus.sh
