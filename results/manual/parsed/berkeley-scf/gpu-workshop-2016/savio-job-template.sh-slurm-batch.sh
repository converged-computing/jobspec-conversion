#!/bin/bash
#SBATCH --job-name=test-gpu
#SBATCH --account=ac_scsguest
#SBATCH --mail-user=paciorek@stat.berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:30:00
#SBATCH --partition=savio2_gpu

module load cuda
module unload intel  # do this to avoid compilation issues
