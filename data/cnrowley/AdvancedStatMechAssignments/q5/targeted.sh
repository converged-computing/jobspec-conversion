#!/bin/bash
#SBATCH --account=rrg-crowley-ac
#SBATCH --output std.out
#SBATCH --mem-per-cpu=1024M 
#SBATCH --mail-type=ALL
#SBATCH --job-name=targeted
#SBATCH --ntasks=8
#SBATCH --nodes=1
#SBATCH --time=12:00:00

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14

namd2 +p8 tip4p-methanol-targeted.conf > tip4p-methanol-targeted.out
