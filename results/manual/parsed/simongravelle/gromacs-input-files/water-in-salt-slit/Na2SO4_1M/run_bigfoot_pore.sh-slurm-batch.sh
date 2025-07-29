#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/simongravelle/gromacs-input-files/water-in-salt-slit/Na2SO4_1M/run_bigfoot_pore.sh
