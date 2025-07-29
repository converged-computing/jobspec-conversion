#!/bin/bash
#SBATCH --job-name=carbon_rodm
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00

SCIPT_DIR=/home/users/degleris/CarbonNetworks.jl/experiments/rodm/
srun hostname
module load julia
srun julia -t 8 ${SCIPT_DIR}${1}
