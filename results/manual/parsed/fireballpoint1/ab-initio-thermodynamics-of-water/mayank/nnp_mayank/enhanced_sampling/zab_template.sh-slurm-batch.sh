#!/bin/bash
#SBATCH --account=research
#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=5-00:00:00
#SBATCH --partition=long
#SBATCH --qos=medium

module load openmpi/4.0.1
