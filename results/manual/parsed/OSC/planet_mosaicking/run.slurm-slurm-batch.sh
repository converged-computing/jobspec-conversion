#!/bin/bash
#SBATCH --job-name=planetpy
#SBATCH --account=PZS0720
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH: --exclusive

export PATH='/users/PZS0530/skhuvis/opt/mambaforge/22.9.0-2/bin:$PATH #mamba'
export PYTHONUNBUFFERED='TRUE'

module load python/3.7-2019.10
export PATH=/users/PZS0530/skhuvis/opt/mambaforge/22.9.0-2/bin:$PATH #mamba
source activate s2s2
export PYTHONUNBUFFERED=TRUE
python ./mosaic.py
