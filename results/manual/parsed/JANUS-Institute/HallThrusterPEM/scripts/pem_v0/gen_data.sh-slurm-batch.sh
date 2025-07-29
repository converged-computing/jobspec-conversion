#!/bin/bash
#SBATCH --job-name=gen_data_v0
#SBATCH --output=./scripts/pem_v0/logs/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=1g
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

export PYTHON_JULIAPKG_OFFLINE='yes'

set -e
echo "Starting job script..."
module load python/3.11.5
export PYTHON_JULIAPKG_OFFLINE=yes
pdm run python scripts/pem_v0/gen_data.py
echo "Finishing job script..."
