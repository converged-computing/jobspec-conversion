#!/bin/bash
#SBATCH --job-name=gen_data_debug
#SBATCH --output=./scripts/debug/logs/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1g
#SBATCH --time=00:03:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

export PYTHON_JULIAPKG_OFFLINE='yes'

set -e
echo "Starting job script..."
module load python/3.11.5
export PYTHON_JULIAPKG_OFFLINE=yes
pdm run python scripts/debug/gen_data.py
echo "Finishing job script..."
