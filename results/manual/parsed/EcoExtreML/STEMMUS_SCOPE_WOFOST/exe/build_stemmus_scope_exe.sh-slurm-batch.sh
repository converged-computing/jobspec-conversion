#!/bin/bash
#SBATCH --job-name=stemmus_scope
#SBATCH --output=./slurm_%j.out
#SBATCH --error=./slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:05:00
#SBATCH --partition=thin

set -euo pipefail
module load 2021
module load MATLAB/2021a-upd3
mcc -m ./src/STEMMUS_SCOPE_exe.m -a ./src -d ./exe -o STEMMUS_SCOPE -R nodisplay -R singleCompThread
