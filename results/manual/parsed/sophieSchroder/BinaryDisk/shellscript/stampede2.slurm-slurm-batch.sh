#!/bin/bash
#SBATCH --job-name=g11hllen
#SBATCH --account=TG-AST150042
#SBATCH --nodes=8
#SBATCH --ntasks=512
#SBATCH --cpus-per-task=1
#SBATCH --time=1-16:00:00
#SBATCH --partition=normal

module purge
module load intel
module load impi
module load phdf5
ibrun ./code/bin/athena -i athinput.binarydisk_stream
