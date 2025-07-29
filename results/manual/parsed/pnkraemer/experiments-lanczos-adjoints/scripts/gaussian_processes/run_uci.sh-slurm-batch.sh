#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pnkraemer/experiments-lanczos-adjoints/scripts/gaussian_processes/run_uci.sh
