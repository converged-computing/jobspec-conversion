#!/bin/bash
#SBATCH --job-name=JobExample1
#SBATCH --output=Example1Out.%j
#SBATCH --nodes=1
#SBATCH --ntasks=100
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20480M
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=10

export PATH='$SCRATCH/programs/EnergyPlus-9-4-0:$PATH'

ml purge
ml intel/2019a
ml CMake/3.15.3-GCCcore-8.3.0
export PATH=$SCRATCH/programs/EnergyPlus-9-4-0:$PATH
mpirun python runTestEplus_parallel.py
