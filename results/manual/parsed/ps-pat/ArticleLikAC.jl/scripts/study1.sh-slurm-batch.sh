#!/bin/bash
#SBATCH --job-name=study1
#SBATCH --account=def-fabricel
#SBATCH --mail-user=fournier.patrick@uqam.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1500M
#SBATCH --time=08:00:00

module load StdEnv/2023 openmpi julia/1.9.3
srun julia --project=../. ../src/study1.jl
