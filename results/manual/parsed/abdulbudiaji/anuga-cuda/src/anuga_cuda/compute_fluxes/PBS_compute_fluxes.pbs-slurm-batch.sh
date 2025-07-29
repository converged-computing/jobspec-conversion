#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/abdulbudiaji/anuga-cuda/src/anuga_cuda/compute_fluxes/PBS_compute_fluxes.pbs
