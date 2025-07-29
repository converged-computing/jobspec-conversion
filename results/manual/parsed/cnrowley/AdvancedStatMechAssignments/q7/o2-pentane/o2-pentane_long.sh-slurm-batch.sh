#!/bin/bash
#SBATCH --job-name=o2-pentane_long
#SBATCH --account=rrg-crowley-ac
#SBATCH --output=std.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1024M
#SBATCH --time=03:00:00

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p8 eq_long.conf > eq_long.out
namd2 +p8 prod_long.conf > prod_long.out
