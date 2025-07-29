#!/bin/bash
#SBATCH --job-name=C90_M3_P30_G50
#SBATCH --output=Example1Out.%j
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20480M
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=15

export PATH='$SCRATCH/programs/EnergyPlus-9-5-0:$PATH'

ml purge
ml intel/2019a
ml CMake/3.15.3-GCCcore-8.3.0
export PATH=$SCRATCH/programs/EnergyPlus-9-5-0:$PATH
mpirun python runTestEplus_parallel.py
