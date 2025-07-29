#!/bin/bash
#SBATCH --job-name=qmc_units_test
#SBATCH --account=def-rgmelko
#SBATCH --output=qmc_units_test-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=00:10:00

module purge
module load julia/1.8.5 StdEnv/2020
julia rydberg_bloqade_ver.jl thermal 16 /home/hpcfung/qmc_test --omega 26.6407057024 --delta -1.545 --radius 1.15 --rand-slice --restart
echo 'qmc program completed'
