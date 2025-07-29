#!/bin/bash
#SBATCH --job-name=cpuinfo
#SBATCH --output=cpuinfo.out
#SBATCH --error=cpuinfo.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

echo "cat /proc/cpuinfo | grep "model name" | uniq"
cat /proc/cpuinfo | grep "model name" | uniq
echo "srun cat /proc/cpuinfo | grep "model name" | uniq"
srun cat /proc/cpuinfo | grep "model name" | uniq
