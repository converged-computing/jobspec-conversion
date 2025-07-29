#!/bin/bash
#SBATCH --account=plgmpr21zeus
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module add plgrid/tools/python-intel/3.6.5 2>/dev/null
mpiexec -n 1 ./zad1.py 7
