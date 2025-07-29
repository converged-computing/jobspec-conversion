#!/bin/bash
#SBATCH --job-name=StatsR3
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load easybuild intel/2017a Python/3.6.1; which python
/usr/bin/time python3 posStatsN.py > statsR3.txt
