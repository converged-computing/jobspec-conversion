#!/bin/bash
#SBATCH --job-name=wps-wrf
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --mail-user=<user>@<domain>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00

module load namd/2.13-gcc_CUDA
namd2 ubq_ws_eq.conf
