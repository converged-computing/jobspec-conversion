#!/bin/bash
#SBATCH --job-name=Threads
#SBATCH --account=SNIC2021-22-752
#SBATCH --output=runf.out.%j
#SBATCH --error=runf.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --constraint=skylake

module purge
module load foss
module load CMake
bash test_n.sh
