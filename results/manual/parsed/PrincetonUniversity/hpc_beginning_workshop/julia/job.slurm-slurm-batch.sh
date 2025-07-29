#!/bin/bash
#SBATCH --job-name=serial_jl
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:01:00

module purge
module load julia/1.5.0
julia hello_world.jl
