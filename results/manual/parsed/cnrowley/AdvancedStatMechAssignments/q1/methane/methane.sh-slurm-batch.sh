#!/bin/bash
#SBATCH --job-name=methane
#SBATCH --account=rrg-crowley-ac
#SBATCH --output=std.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1024M
#SBATCH --time=03:00:00

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p4 methane.conf > methane.out
