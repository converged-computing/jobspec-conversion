#!/bin/bash
#SBATCH --job-name=amd
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=64

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module load openmpi/4.0.5/amd
module load conda
source activate rlotus
sleep 720000
