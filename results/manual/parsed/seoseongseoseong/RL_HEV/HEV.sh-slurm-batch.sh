#!/bin/bash
#SBATCH --job-name=sleep
#SBATCH --output=out.sleep.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --partition=normal

module purge
module ohpc
date
for tau in $(seq 0.0001 0.0001 0.0005); do
    echo "Running script with tau=$tau"
    python main.py --tau $tau &
done
wait
date
