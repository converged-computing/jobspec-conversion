#!/bin/bash
#SBATCH --job-name=name
#SBATCH --output=a.out
#SBATCH --error=a.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1

cd path
/home/alfredo/Software/NAMD_Git-2021-03-23_Linux-x86_64-multicore/namd2 +auto-provision +isomalloc_sync namd > 1.log
