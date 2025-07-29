#!/bin/bash
#SBATCH --account=nesi99999
#SBATCH --output=logs/%j-%x.out
#SBATCH --error=logs/%j-%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --mem=80GB
#SBATCH --time=00:10:00
#SBATCH --partition=milan

export PYTHONNOUSERSITE='1'
export DASK_DISTRIBUTED__WORKER__MEMORY__TARGET='False'
export DASK_DISTRIBUTED__WORKER__MEMORY__SPILL='False'
export DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE='0.80'
export DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE='0.95'

module purge && module load Miniconda3/22.11.1-1
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
conda deactivate
conda activate ./venv
export DASK_DISTRIBUTED__WORKER__MEMORY__TARGET=False
export DASK_DISTRIBUTED__WORKER__MEMORY__SPILL=False
export DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE=0.80
export DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE=0.95
python scripts/hyperparameters_search.py
